using System;
using System.Data;
using System.Web.UI;

public partial class UserProfile : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckLogin();
        
        if (!IsPostBack)
        {
            LoadUserProfile();
        }
    }

    private void LoadUserProfile()
    {
        try
        {
            string query = "SELECT * FROM Users WHERE CustomerID = " + CustomerID;
            DataTable dt = DBHelper.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                txtFullName.Text = row["FullName"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                txtAddress.Text = row["Address"].ToString();
                txtCity.Text = row["City"].ToString();
                txtState.Text = row["State"].ToString();
                txtPinCode.Text = row["PinCode"].ToString();

                lblCustomerID.Text = row["CustomerID"].ToString();
                lblMemberSince.Text = Convert.ToDateTime(row["RegisteredDate"]).ToString("dd MMM yyyy");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error loading profile: " + ex.Message, "danger");
        }
    }

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        try
        {
            // Validate phone number
            if (txtPhone.Text.Length != 10 || !IsNumeric(txtPhone.Text))
            {
                ShowMessage("Please enter a valid 10-digit phone number!", "danger");
                return;
            }

            string query = @"UPDATE Users SET 
                            FullName = @FullName, 
                            Phone = @Phone, 
                            Address = @Address, 
                            City = @City, 
                            State = @State, 
                            PinCode = @PinCode 
                            WHERE CustomerID = " + CustomerID;

            System.Data.SqlClient.SqlParameter[] parameters = new System.Data.SqlClient.SqlParameter[]
            {
                new System.Data.SqlClient.SqlParameter("@FullName", txtFullName.Text.Trim()),
                new System.Data.SqlClient.SqlParameter("@Phone", txtPhone.Text.Trim()),
                new System.Data.SqlClient.SqlParameter("@Address", txtAddress.Text.Trim()),
                new System.Data.SqlClient.SqlParameter("@City", txtCity.Text.Trim()),
                new System.Data.SqlClient.SqlParameter("@State", txtState.Text.Trim()),
                new System.Data.SqlClient.SqlParameter("@PinCode", txtPinCode.Text.Trim())
            };

            int result = DBHelper.ExecuteNonQuery(query, parameters);

            if (result > 0)
            {
                // Update session
                Session["CustomerName"] = txtFullName.Text.Trim();
                
                ShowMessage("Profile updated successfully!", "success");
                LoadUserProfile();
            }
            else
            {
                ShowMessage("Failed to update profile. Please try again.", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error updating profile: " + ex.Message, "danger");
        }
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        pnlPersonalInfo.Visible = false;
        pnlChangePassword.Visible = true;
        pnlMessage.Visible = false;
    }

    protected void btnCancelPassword_Click(object sender, EventArgs e)
    {
        pnlChangePassword.Visible = false;
        pnlPersonalInfo.Visible = true;
        ClearPasswordFields();
        pnlMessage.Visible = false;
    }

    protected void btnSavePassword_Click(object sender, EventArgs e)
    {
        try
        {
            // Validate passwords
            if (txtNewPassword.Text.Length < 6)
            {
                ShowMessage("New password must be at least 6 characters long!", "danger");
                return;
            }

            if (txtNewPassword.Text != txtConfirmNewPassword.Text)
            {
                ShowMessage("New passwords do not match!", "danger");
                return;
            }

            // Verify current password
            string currentPasswordHash = DBHelper.HashPassword(txtCurrentPassword.Text);
            string query = "SELECT CustomerID FROM Users WHERE CustomerID = " + CustomerID + " AND Password = @Password";

            System.Data.SqlClient.SqlParameter[] checkParams = new System.Data.SqlClient.SqlParameter[]
            {
                new System.Data.SqlClient.SqlParameter("@Password", currentPasswordHash)
            };

            object result = DBHelper.ExecuteScalar(query, checkParams);

            if (result == null)
            {
                ShowMessage("Current password is incorrect!", "danger");
                return;
            }

            // Update password
            string newPasswordHash = DBHelper.HashPassword(txtNewPassword.Text);
            string updateQuery = "UPDATE Users SET Password = @NewPassword WHERE CustomerID = " + CustomerID;

            System.Data.SqlClient.SqlParameter[] updateParams = new System.Data.SqlClient.SqlParameter[]
            {
                new System.Data.SqlClient.SqlParameter("@NewPassword", newPasswordHash)
            };

            int updateResult = DBHelper.ExecuteNonQuery(updateQuery, updateParams);

            if (updateResult > 0)
            {
                ShowMessage("Password changed successfully!", "success");
                pnlChangePassword.Visible = false;
                pnlPersonalInfo.Visible = true;
                ClearPasswordFields();
            }
            else
            {
                ShowMessage("Failed to change password. Please try again.", "danger");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("Error changing password: " + ex.Message, "danger");
        }
    }

    private void ClearPasswordFields()
    {
        txtCurrentPassword.Text = "";
        txtNewPassword.Text = "";
        txtConfirmNewPassword.Text = "";
    }

    private bool IsNumeric(string value)
    {
        long result;
        return long.TryParse(value, out result);
    }

    private void ShowMessage(string message, string type)
    {
        pnlMessage.Visible = true;
        pnlMessage.CssClass = "notification " + type;
        pnlMessage.Controls.Clear();
        pnlMessage.Controls.Add(new System.Web.UI.LiteralControl(message));
    }
}
