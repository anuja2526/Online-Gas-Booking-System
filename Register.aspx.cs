using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Register : System.Web.UI.Page
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

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        try
        {
            // Validate passwords match
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("Passwords do not match!", "danger");
                return;
            }

            // Validate phone number
            if (txtPhone.Text.Length != 10 || !IsNumeric(txtPhone.Text))
            {
                ShowMessage("Please enter a valid 10-digit phone number!", "danger");
                return;
            }

            // Hash the password
            string hashedPassword = DBHelper.HashPassword(txtPassword.Text);

            // Prepare parameters for stored procedure
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@FullName", txtFullName.Text.Trim()),
                new SqlParameter("@Email", txtEmail.Text.Trim()),
                new SqlParameter("@Password", hashedPassword),
                new SqlParameter("@Phone", txtPhone.Text.Trim()),
                new SqlParameter("@Address", txtAddress.Text.Trim()),
                new SqlParameter("@City", txtCity.Text.Trim()),
                new SqlParameter("@State", txtState.Text.Trim()),
                new SqlParameter("@PinCode", txtPinCode.Text.Trim())
            };

            // Execute stored procedure
            DataTable dt = DBHelper.ExecuteStoredProcedure("sp_RegisterUser", parameters);

            if (dt.Rows.Count > 0)
            {
                int result = Convert.ToInt32(dt.Rows[0]["Result"]);
                string message = dt.Rows[0]["Message"].ToString();

                if (result > 0)
                {
                    ShowMessage("Registration successful! Please login.", "success");
                    
                    // Clear form
                    ClearForm();
                    
                    // Redirect to login after 2 seconds
                    Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                }
                else
                {
                    ShowMessage(message, "danger");
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Registration failed: " + ex.Message, "danger");
        }
    }

    private bool IsNumeric(string value)
    {
        long result;
        return long.TryParse(value, out result);
    }

    private void ClearForm()
    {
        txtFullName.Text = "";
        txtEmail.Text = "";
        txtPhone.Text = "";
        txtPassword.Text = "";
        txtConfirmPassword.Text = "";
        txtAddress.Text = "";
        txtCity.Text = "";
        txtState.Text = "";
        txtPinCode.Text = "";
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "notification " + type;
        pnlMessage.Controls.Clear();
        pnlMessage.Controls.Add(new System.Web.UI.LiteralControl(message));
    }
}
