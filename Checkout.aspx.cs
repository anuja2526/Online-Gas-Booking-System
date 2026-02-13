using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Checkout : BasePage
{
    private DataTable cartItems;
    private BillingResult billing;

    protected void Page_Load(object sender, EventArgs e)
    {
        CheckLogin();
        
        if (!IsPostBack)
        {
            LoadUserInfo();
            LoadCartSummary();
        }
    }

    private void LoadUserInfo()
    {
        try
        {
            string query = "SELECT * FROM Users WHERE CustomerID = " + CustomerID;
            DataTable dt = DBHelper.ExecuteQuery(query);
            
            if (dt.Rows.Count > 0)
            {
                txtDeliveryAddress.Text = dt.Rows[0]["Address"].ToString();
                txtCity.Text = dt.Rows[0]["City"].ToString();
                txtState.Text = dt.Rows[0]["State"].ToString();
                txtPinCode.Text = dt.Rows[0]["PinCode"].ToString();
            }
        }
        catch { }
    }

    private void LoadCartSummary()
    {
        try
        {
            string query = @"SELECT c.Quantity, c.ProductID, p.ProductName, p.Price 
                            FROM Cart c 
                            INNER JOIN GasProducts p ON c.ProductID = p.ProductID 
                            WHERE c.CustomerID = " + CustomerID;

            cartItems = DBHelper.ExecuteQuery(query);

            if (cartItems.Rows.Count == 0)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            rptOrderItems.DataSource = cartItems;
            rptOrderItems.DataBind();

            // Calculate totals
            decimal subtotal = 0;
            foreach (DataRow row in cartItems.Rows)
            {
                subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            }

            billing = BillingEngine.CalculateTotal(subtotal);

            lblSubtotal.Text = billing.Subtotal.ToString("N2");
            lblTax.Text = billing.Tax.ToString("N2");
            lblDeliveryCharges.Text = billing.DeliveryCharges.ToString("N2");
            lblGrandTotal.Text = billing.GrandTotal.ToString("N2");
        }
        catch (Exception ex)
        {
            Response.Redirect("Cart.aspx");
        }
    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        try
        {
            LoadCartSummary(); // Reload to get latest data
            
            string orderNumber = BillingEngine.GenerateInvoiceNumber();

            // Create booking using stored procedure
            SqlParameter[] bookingParams = new SqlParameter[]
            {
                new SqlParameter("@CustomerID", CustomerID),
                new SqlParameter("@OrderNumber", orderNumber),
                new SqlParameter("@TotalAmount", billing.Subtotal),
                new SqlParameter("@Tax", billing.Tax),
                new SqlParameter("@DeliveryCharges", billing.DeliveryCharges),
                new SqlParameter("@GrandTotal", billing.GrandTotal),
                new SqlParameter("@DeliveryAddress", txtDeliveryAddress.Text.Trim()),
                new SqlParameter("@DeliveryCity", txtCity.Text.Trim()),
                new SqlParameter("@DeliveryState", txtState.Text.Trim()),
                new SqlParameter("@DeliveryPinCode", txtPinCode.Text.Trim())
            };

            DataTable dt = DBHelper.ExecuteStoredProcedure("sp_CreateBooking", bookingParams);
            int bookingId = Convert.ToInt32(dt.Rows[0]["BookingID"]);

            // Add booking details
            foreach (DataRow row in cartItems.Rows)
            {
                decimal price = Convert.ToDecimal(row["Price"]);
                int quantity = Convert.ToInt32(row["Quantity"]);
                
                string detailQuery = string.Format(
                    "INSERT INTO BookingDetails (BookingID, ProductID, Quantity, UnitPrice, TotalPrice) VALUES ({0}, {1}, {2}, {3}, {4})",
                    bookingId, row["ProductID"], quantity, price, price * quantity);
                
                DBHelper.ExecuteNonQuery(detailQuery);
            }

            // Add payment record
            string paymentQuery = string.Format(
                "INSERT INTO Payments (BookingID, PaymentMethod, PaymentStatus, Amount, TransactionID) VALUES ({0}, '{1}', 'Completed', {2}, '{3}')",
                bookingId, rblPaymentMethod.SelectedValue, billing.GrandTotal, "TXN" + orderNumber);
            
            DBHelper.ExecuteNonQuery(paymentQuery);

            // Clear cart
            string clearCartQuery = "DELETE FROM Cart WHERE CustomerID = " + CustomerID;
            DBHelper.ExecuteNonQuery(clearCartQuery);

            // Redirect to invoice
            Response.Redirect("Invoice.aspx?id=" + bookingId);
        }
        catch (Exception ex)
        {
            string script = "HPGas.showNotification('Error placing order: " + ex.Message.Replace("'", "\\'") + "', 'error');";
            ScriptManager.RegisterStartupScript(this, GetType(), "orderError", script, true);
        }
    }
}
