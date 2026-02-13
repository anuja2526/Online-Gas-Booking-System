using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cart : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckLogin();
        
        if (!IsPostBack)
        {
            LoadCart();
        }
    }

    private void LoadCart()
    {
        try
        {
            string query = @"SELECT c.CartID, c.Quantity, c.ProductID, p.ProductName, p.Price, p.ImageUrl, 
                            p.Weight, p.WeightUnit 
                            FROM Cart c 
                            INNER JOIN GasProducts p ON c.ProductID = p.ProductID 
                            WHERE c.CustomerID = " + CustomerID;

            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                gvCart.DataSource = dt;
                gvCart.DataBind();
                
                CalculateTotals(dt);
                
                pnlCart.Visible = true;
                pnlEmptyCart.Visible = false;
            }
            else
            {
                pnlCart.Visible = false;
                pnlEmptyCart.Visible = true;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error loading cart: " + ex.Message);
        }
    }

    private void CalculateTotals(DataTable dt)
    {
        decimal subtotal = 0;
        
        foreach (DataRow row in dt.Rows)
        {
            decimal price = Convert.ToDecimal(row["Price"]);
            int quantity = Convert.ToInt32(row["Quantity"]);
            subtotal += (price * quantity);
        }

        BillingResult billing = BillingEngine.CalculateTotal(subtotal);

        lblSubtotal.Text = billing.Subtotal.ToString("N2");
        lblTax.Text = billing.Tax.ToString("N2");
        lblDeliveryCharges.Text = billing.DeliveryCharges.ToString("N2");
        lblGrandTotal.Text = billing.GrandTotal.ToString("N2");
    }

    protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int cartId = 0;
        
        if (e.CommandName == "RemoveItem")
        {
            cartId = Convert.ToInt32(e.CommandArgument);
            RemoveFromCart(cartId);
        }
        else if (e.CommandName == "UpdateQuantity")
        {
            string[] args = e.CommandArgument.ToString().Split(',');
            cartId = Convert.ToInt32(args[0]);
            int change = Convert.ToInt32(args[1]);
            UpdateQuantity(cartId, change);
        }
        
        LoadCart();
    }

    private void RemoveFromCart(int cartId)
    {
        try
        {
            string query = "DELETE FROM Cart WHERE CartID = " + cartId + " AND CustomerID = " + CustomerID;
            DBHelper.ExecuteNonQuery(query);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error removing from cart: " + ex.Message);
        }
    }

    private void UpdateQuantity(int cartId, int change)
    {
        try
        {
            string query = "UPDATE Cart SET Quantity = Quantity + " + change + 
                          " WHERE CartID = " + cartId + " AND CustomerID = " + CustomerID + 
                          " AND (Quantity + " + change + ") > 0";
            DBHelper.ExecuteNonQuery(query);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error updating quantity: " + ex.Message);
        }
    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }
}
