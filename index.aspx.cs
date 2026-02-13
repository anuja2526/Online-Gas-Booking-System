using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadFeaturedProducts();
        }
    }

    private void LoadFeaturedProducts()
    {
        try
        {
            string query = "SELECT TOP 3 * FROM GasProducts WHERE IsActive = 1 ORDER BY ProductID";
            DataTable dt = DBHelper.ExecuteQuery(query);
            
            if (dt.Rows.Count > 0)
            {
                rptFeaturedProducts.DataSource = dt;
                rptFeaturedProducts.DataBind();
            }
        }
        catch (Exception ex)
        {
            // Log error
            System.Diagnostics.Debug.WriteLine("Error loading products: " + ex.Message);
        }
    }
}