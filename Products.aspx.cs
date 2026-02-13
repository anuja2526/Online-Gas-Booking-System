using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Products : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadProducts();
        }
    }

    private void LoadProducts(string category = "")
    {
        try
        {
            string query = "SELECT * FROM GasProducts WHERE IsActive = 1";
            
            if (!string.IsNullOrEmpty(category))
            {
                query += " AND Category = @Category";
            }
            
            query += " ORDER BY ProductName";

            DataTable dt;
            if (!string.IsNullOrEmpty(category))
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Category", category)
                };
                dt = DBHelper.ExecuteQuery(query, parameters);
            }
            else
            {
                dt = DBHelper.ExecuteQuery(query);
            }

            if (dt.Rows.Count > 0)
            {
                rptProducts.DataSource = dt;
                rptProducts.DataBind();
                pnlNoProducts.Visible = false;
            }
            else
            {
                rptProducts.DataSource = null;
                rptProducts.DataBind();
                pnlNoProducts.Visible = true;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error loading products: " + ex.Message);
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadProducts(ddlCategory.SelectedValue);
    }

    protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "AddToCart")
        {
            // Check if user is logged in
            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx?ret=" + Server.UrlEncode(Request.Url.PathAndQuery));
                return;
            }

            try
            {
                int customerId = Convert.ToInt32(Session["CustomerID"]);
                int productId = Convert.ToInt32(e.CommandArgument);

                // Add to cart using stored procedure
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@CustomerID", customerId),
                    new SqlParameter("@ProductID", productId),
                    new SqlParameter("@Quantity", 1)
                };

                DataTable dt = DBHelper.ExecuteStoredProcedure("sp_AddToCart", parameters);

                if (dt.Rows.Count > 0 && Convert.ToInt32(dt.Rows[0]["Result"]) == 1)
                {
                    // Show success message and reload
                    string script = "HPGas.showNotification('Product added to cart!', 'success');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "cartAdded", script, true);
                }
            }
            catch (Exception ex)
            {
                string script = "HPGas.showNotification('Error adding to cart: " + ex.Message.Replace("'", "\\'") + "', 'error');";
                ScriptManager.RegisterStartupScript(this, GetType(), "cartError", script, true);
            }
        }
    }
}
