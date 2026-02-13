using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class ProductDetails : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int productId = 0;
            if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out productId))
            {
                LoadProductDetails(productId);
            }
            else
            {
                Response.Redirect("Products.aspx");
            }
        }
    }

    private void LoadProductDetails(int productId)
    {
        try
        {
            string query = "SELECT * FROM GasProducts WHERE ProductID = " + productId + " AND IsActive = 1";
            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                lblProductName.Text = row["ProductName"].ToString();
                lblBrand.Text = row["Brand"].ToString();
                lblCategory.Text = row["Category"].ToString();
                lblWeight.Text = row["Weight"].ToString() + " " + row["WeightUnit"].ToString();
                lblPrice.Text = Convert.ToDecimal(row["Price"]).ToString("N2");
                lblDescription.Text = row["Description"].ToString();

                // Product image
                imgProduct.ImageUrl = row["ImageUrl"].ToString();
                imgProduct.AlternateText = row["ProductName"].ToString();

                // Stock status
                int stock = Convert.ToInt32(row["Stock"]);
                if (stock > 0)
                {
                    lblStockBadge.Text = "In Stock";
                    lblStockBadge.CssClass = "badge badge-success";
                    lblStockStatus.Text = stock + " units available";
                    btnAddToCart.Enabled = true;
                }
                else
                {
                    lblStockBadge.Text = "Out of Stock";
                    lblStockBadge.CssClass = "badge badge-danger";
                    lblStockStatus.Text = "Currently unavailable";
                    btnAddToCart.Enabled = false;
                }

                // Details table
                lblBrandDetail.Text = row["Brand"].ToString();
                lblWeightDetail.Text = row["Weight"].ToString() + " " + row["WeightUnit"].ToString();
                lblCategoryDetail.Text = row["Category"].ToString();
                lblPriceDetail.Text = Convert.ToDecimal(row["Price"]).ToString("N2");
            }
            else
            {
                Response.Redirect("Products.aspx");
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("Products.aspx");
        }
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        if (!IsUserLoggedIn)
        {
            Response.Redirect("Login.aspx?returnUrl=" + Request.RawUrl);
            return;
        }

        try
        {
            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int quantity = Convert.ToInt32(txtQuantity.Text);

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CustomerID", CustomerID),
                new SqlParameter("@ProductID", productId),
                new SqlParameter("@Quantity", quantity)
            };

            DBHelper.ExecuteStoredProcedure("sp_AddToCart", parameters);

            string script = "HPGas.showNotification('Product added to cart!', 'success'); setTimeout(function(){ window.location.href='Cart.aspx'; }, 1500);";
            ScriptManager.RegisterStartupScript(this, GetType(), "addToCart", script, true);
        }
        catch (Exception ex)
        {
            string script = "HPGas.showNotification('Error adding to cart: " + ex.Message.Replace("'", "\\'") + "', 'error');";
            ScriptManager.RegisterStartupScript(this, GetType(), "error", script, true);
        }
    }
}
