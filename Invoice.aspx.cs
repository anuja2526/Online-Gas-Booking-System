using System;
using System.Data;
using System.Web.UI;

public partial class Invoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int bookingId = 0;
            if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out bookingId))
            {
                LoadInvoice(bookingId);
            }
            else
            {
                Response.Redirect("UserDashboard.aspx");
            }
        }
    }

    private void LoadInvoice(int bookingId)
    {
        try
        {
            // Get booking details
            string query = @"SELECT b.*, u.FullName, u.Email, u.Phone, u.Address, u.City, u.State, u.PinCode 
                            FROM Bookings b 
                            INNER JOIN Users u ON b.CustomerID = u.CustomerID 
                            WHERE b.BookingID = " + bookingId;

            DataTable dtBooking = DBHelper.ExecuteQuery(query);

            if (dtBooking.Rows.Count == 0)
            {
                Response.Redirect("UserDashboard.aspx");
                return;
            }

            DataRow booking = dtBooking.Rows[0];

            // Set invoice header
            lblInvoiceNumber.Text = booking["OrderNumber"].ToString();
            lblInvoiceDate.Text = Convert.ToDateTime(booking["BookingDate"]).ToString("dd MMM yyyy");
            lblStatus.Text = booking["Status"].ToString();
            lblStatus.CssClass = "badge badge-" + GetStatusClass(booking["Status"].ToString());

            // Set customer details
            lblCustomerName.Text = booking["FullName"].ToString();
            lblCustomerEmail.Text = booking["Email"].ToString();
            lblCustomerPhone.Text = booking["Phone"].ToString();
            
            string address = booking["Address"].ToString();
            if (!string.IsNullOrEmpty(booking["City"].ToString()))
                address += ", " + booking["City"].ToString();
            if (!string.IsNullOrEmpty(booking["State"].ToString()))
                address += ", " + booking["State"].ToString();
            if (!string.IsNullOrEmpty(booking["PinCode"].ToString()))
                address += " - " + booking["PinCode"].ToString();
            
            lblCustomerAddress.Text = address;

            // Set totals
            lblSubtotal.Text = Convert.ToDecimal(booking["TotalAmount"]).ToString("N2");
            lblTax.Text = Convert.ToDecimal(booking["Tax"]).ToString("N2");
            lblDeliveryCharges.Text = Convert.ToDecimal(booking["DeliveryCharges"]).ToString("N2");
            lblGrandTotal.Text = Convert.ToDecimal(booking["GrandTotal"]).ToString("N2");

            // Set delivery address
            string deliveryAddress = booking["DeliveryAddress"].ToString();
            if (!string.IsNullOrEmpty(booking["DeliveryCity"].ToString()))
                deliveryAddress += ", " + booking["DeliveryCity"].ToString();
            if (!string.IsNullOrEmpty(booking["DeliveryState"].ToString()))
                deliveryAddress += ", " + booking["DeliveryState"].ToString();
            if (!string.IsNullOrEmpty(booking["DeliveryPinCode"].ToString()))
                deliveryAddress += " - " + booking["DeliveryPinCode"].ToString();
            
            lblDeliveryAddress.Text = deliveryAddress;

            // Get payment details
            string paymentQuery = "SELECT * FROM Payments WHERE BookingID = " + bookingId;
            DataTable dtPayment = DBHelper.ExecuteQuery(paymentQuery);

            if (dtPayment.Rows.Count > 0)
            {
                lblPaymentMethod.Text = dtPayment.Rows[0]["PaymentMethod"].ToString();
                lblPaymentStatus.Text = dtPayment.Rows[0]["PaymentStatus"].ToString();
                lblTransactionID.Text = dtPayment.Rows[0]["TransactionID"].ToString();
            }

            // Get order items
            string itemsQuery = @"SELECT bd.*, p.ProductName 
                                 FROM BookingDetails bd 
                                 INNER JOIN GasProducts p ON bd.ProductID = p.ProductID 
                                 WHERE bd.BookingID = " + bookingId;

            DataTable dtItems = DBHelper.ExecuteQuery(itemsQuery);
            rptInvoiceItems.DataSource = dtItems;
            rptInvoiceItems.DataBind();
        }
        catch (Exception ex)
        {
            Response.Redirect("UserDashboard.aspx");
        }
    }

    private string GetStatusClass(string status)
    {
        switch (status.ToLower())
        {
            case "completed":
            case "delivered":
                return "success";
            case "pending":
                return "warning";
            case "cancelled":
                return "danger";
            default:
                return "primary";
        }
    }
}
