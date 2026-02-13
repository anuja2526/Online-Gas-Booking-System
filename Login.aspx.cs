using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if user is already logged in
            if (Session["CustomerID"] != null)
            {
                Response.Redirect("UserDashboard.aspx");
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            // Hash the password
            string hashedPassword = DBHelper.HashPassword(txtPassword.Text);

            // Prepare parameters
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Email", txtEmail.Text.Trim()),
                new SqlParameter("@Password", hashedPassword)
            };

            // Execute stored procedure
            DataTable dt = DBHelper.ExecuteStoredProcedure("sp_UserLogin", parameters);

            if (dt.Rows.Count > 0)
            {
                // Login successful
                Session["CustomerID"] = dt.Rows[0]["CustomerID"];
                Session["CustomerName"] = dt.Rows[0]["FullName"];
                Session["CustomerEmail"] = dt.Rows[0]["Email"];

                // Check if there's a return URL
                string returnUrl = Request.QueryString["ret"];
                if (!string.IsNullOrEmpty(returnUrl))
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    Response.Redirect("UserDashboard.aspx");
                }
            }
            else
            {
                ShowMessage("Invalid email or password!", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Login failed: " + ex.Message, "danger");
        }
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "notification " + type;
        pnlMessage.Controls.Clear();
        pnlMessage.Controls.Add(new System.Web.UI.LiteralControl(message));
    }
}
