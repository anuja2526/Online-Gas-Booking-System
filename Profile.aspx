<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Profile.aspx.cs" Inherits="UserProfile" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <h2>My Profile</h2>
                <p class="text-light">Manage your personal information and account settings</p>

                <div class="row" style="margin-top: 2rem;">
                    <div class="col col-8" style="min-width: 0;">
                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-3"></asp:Panel>

                        <asp:Panel ID="pnlPersonalInfo" runat="server">
                            <div class="card">
                                <h3>Personal Information</h3>
                                <hr />

                                <div class="form-group">
                                    <label class="form-label">Full Name *</label>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Email Address *</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"
                                        style="background: #f5f5f5;"></asp:TextBox>
                                    <small class="text-light">Email cannot be changed</small>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Phone Number *</label>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="10">
                                    </asp:TextBox>
                                </div>

                                <h3 style="margin-top: 2rem;">Address Details</h3>
                                <hr />

                                <div class="form-group">
                                    <label class="form-label">Street Address</label>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"
                                        TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>

                                <div class="row">
                                    <div class="col col-6">
                                        <div class="form-group">
                                            <label class="form-label">City</label>
                                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col col-6">
                                        <div class="form-group">
                                            <label class="form-label">State</label>
                                            <asp:TextBox ID="txtState" runat="server" CssClass="form-control">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Pin Code</label>
                                    <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control" MaxLength="6">
                                    </asp:TextBox>
                                </div>

                                <div style="margin-top: 2rem;">
                                    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile"
                                        CssClass="btn btn-primary" OnClick="btnUpdateProfile_Click" />
                                    <a href="UserDashboard.aspx" class="btn btn-outline"
                                        style="margin-left: 1rem;">Cancel</a>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- <asp:Panel ID="pnlChangePassword" runat="server" Visible="false">
                            <div class="card">
                                <h3>Change Password</h3>
                                <hr />

                                <div class="form-group">
                                    <label class="form-label">Current Password *</label>
                                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control"
                                        TextMode="Password"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">New Password *</label>
                                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control"
                                        TextMode="Password"></asp:TextBox>
                                    <small class="text-light">Minimum 6 characters</small>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Confirm New Password *</label>
                                    <asp:TextBox ID="txtConfirmNewPassword" runat="server" CssClass="form-control"
                                        TextMode="Password"></asp:TextBox>
                                </div>

                                <div style="margin-top: 2rem;">
                                    <asp:Button ID="btnSavePassword" runat="server" Text="Save New Password"
                                        CssClass="btn btn-primary" OnClick="btnSavePassword_Click" />
                                    <asp:Button ID="btnCancelPassword" runat="server" Text="Cancel"
                                        CssClass="btn btn-outline" style="margin-left: 1rem;"
                                        OnClick="btnCancelPassword_Click" />
                                </div>
                            </div>
                        </asp:Panel> -->
                    </div>

                    <div class="col col-4" style="min-width: 0;">
                        <div class="card">
                            <h3>Account Info</h3>
                            <hr />
                            <p><strong>Customer ID:</strong><br />
                                <asp:Label ID="lblCustomerID" runat="server"></asp:Label>
                            </p>
                            <p><strong>Member Since:</strong><br />
                                <asp:Label ID="lblMemberSince" runat="server"></asp:Label>
                            </p>
                            <p><strong>Account Status:</strong><br /><span class="badge badge-success">Active</span></p>
                        </div>

                        <!-- <div class="card" style="margin-top: 1.5rem;">
                            <h3>Security</h3>
                            <hr />
                            <p class="text-light" style="font-size: 0.9rem;">Update your password regularly to keep your
                                account safe.</p>
                            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password"
                                CssClass="btn btn-outline" style="width: 100%;" OnClick="btnChangePassword_Click" />
                        </div> -->
                    </div>
                </div>
        </section>
    </asp:Content>