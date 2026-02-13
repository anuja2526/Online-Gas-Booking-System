using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderHistory : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckLogin();
        
        if (!IsPostBack)
        {
            LoadOrderHistory();
        }
    }

    private void LoadOrderHistory()
    {
        try
        {
            string query = @"SELECT b.BookingID, b.OrderNumber, b.BookingDate, b.TotalAmount, b.Tax, 
                            b.DeliveryCharges, b.GrandTotal, b.Status, b.DeliveryCity, b.DeliveryState,
                            (SELECT COUNT(*) FROM BookingDetails WHERE BookingID = b.BookingID) as ItemCount
                            FROM Bookings b
                            WHERE b.CustomerID = " + CustomerID + @"
                            ORDER BY b.BookingDate DESC";

            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                gvOrderHistory.DataSource = dt;
                gvOrderHistory.DataBind();
                pnlNoOrders.Visible = false;
            }
            else
            {
                gvOrderHistory.DataSource = null;
                gvOrderHistory.DataBind();
                pnlNoOrders.Visible = true;
            }
        }
        catch (Exception ex)
        {
            pnlNoOrders.Visible = true;
        }
    }

    protected void btnViewDetails_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "ViewDetails")
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);
            LoadOrderDetails(bookingId);
        }
    }

    private void LoadOrderDetails(int bookingId)
    {
        try
        {
            // Get booking details
            string query = "SELECT * FROM Bookings WHERE BookingID = " + bookingId + " AND CustomerID = " + CustomerID;
            DataTable dtBooking = DBHelper.ExecuteQuery(query);

            if (dtBooking.Rows.Count > 0)
            {
                DataRow booking = dtBooking.Rows[0];

                lblDetailOrderNumber.Text = booking["OrderNumber"].ToString();
                lblDetailOrderDate.Text = Convert.ToDateTime(booking["BookingDate"]).ToString("dd MMM yyyy HH:mm");
                lblDetailStatus.Text = booking["Status"].ToString();
                lblDetailStatus.CssClass = "badge badge-" + GetStatusClass(booking["Status"].ToString());

                lblDetailDeliveryAddress.Text = booking["DeliveryAddress"].ToString() + "<br/>" +
                                                booking["DeliveryCity"].ToString() + ", " +
                                                booking["DeliveryState"].ToString() + " - " +
                                                booking["DeliveryPinCode"].ToString();

                lblDetailSubtotal.Text = Convert.ToDecimal(booking["TotalAmount"]).ToString("N2");
                lblDetailTax.Text = Convert.ToDecimal(booking["Tax"]).ToString("N2");
                lblDetailDelivery.Text = Convert.ToDecimal(booking["DeliveryCharges"]).ToString("N2");
                lblDetailGrandTotal.Text = Convert.ToDecimal(booking["GrandTotal"]).ToString("N2");

                // Get order items
                string itemsQuery = @"SELECT bd.*, p.ProductName 
                                     FROM BookingDetails bd 
                                     INNER JOIN GasProducts p ON bd.ProductID = p.ProductID 
                                     WHERE bd.BookingID = " + bookingId;

                DataTable dtItems = DBHelper.ExecuteQuery(itemsQuery);
                rptOrderItems.DataSource = dtItems;
                rptOrderItems.DataBind();

                pnlOrderDetails.Visible = true;
            }
        }
        catch { }
    }

    protected void btnCloseDetails_Click(object sender, EventArgs e)
    {
        pnlOrderDetails.Visible = false;
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
            case "processing":
            case "shipped":
                return "primary";
            default:
                return "secondary";
        }
    }
}
