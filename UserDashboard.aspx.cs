using System;
using System.Data;
using System.Web.UI;

public partial class UserDashboard : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckLogin();
        
        if (!IsPostBack)
        {
            lblCustomerName.Text = CustomerName;
            LoadStatistics();
            LoadRecentOrders();
        }
    }

    private void LoadStatistics()
    {
        try
        {
            // Total orders
            string query = "SELECT COUNT(*) FROM Bookings WHERE CustomerID = " + CustomerID;
            object totalOrders = DBHelper.ExecuteScalar(query);
            lblTotalOrders.Text = totalOrders != null ? totalOrders.ToString() : "0";

            // Pending orders
            query = "SELECT COUNT(*) FROM Bookings WHERE CustomerID = " + CustomerID + " AND Status = 'Pending'";
            object pendingOrders = DBHelper.ExecuteScalar(query);
            lblPendingOrders.Text = pendingOrders != null ? pendingOrders.ToString() : "0";

            // Total spent
            query = "SELECT ISNULL(SUM(GrandTotal), 0) FROM Bookings WHERE CustomerID = " + CustomerID;
            object totalSpent = DBHelper.ExecuteScalar(query);
            lblTotalSpent.Text = totalSpent != null ? Convert.ToDecimal(totalSpent).ToString("N2") : "0.00";
        }
        catch { }
    }

    private void LoadRecentOrders()
    {
        try
        {
            string query = @"SELECT TOP 5 BookingID, OrderNumber, BookingDate, GrandTotal, Status 
                            FROM Bookings 
                            WHERE CustomerID = " + CustomerID + @" 
                            ORDER BY BookingDate DESC";

            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                gvRecentOrders.DataSource = dt;
                gvRecentOrders.DataBind();
                pnlNoOrders.Visible = false;
            }
            else
            {
                gvRecentOrders.DataSource = null;
                gvRecentOrders.DataBind();
                pnlNoOrders.Visible = true;
            }
        }
        catch { }
    }

    protected string GetStatusClass(string status)
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
