<%@ Page Title="Register" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Register" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col col-6" style="margin: 0 auto;">
                        <div class="card scale-in">
                            <h2 class="text-center">Create Your Account</h2>
                            <p class="text-center text-light mb-4">Join HP Gas for easy booking</p>

                            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-3"></asp:Panel>

                            <div class="form-group">
                                <label class="form-label">Full Name *</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"
                                    placeholder="Enter your full name" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Email Address *</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"
                                    placeholder="your.email@example.com" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Phone Number *</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"
                                    placeholder="10-digit mobile number" MaxLength="10" required="required">
                                </asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Password *</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"
                                    placeholder="Create a strong password" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Confirm Password *</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"
                                    TextMode="Password" placeholder="Re-enter your password" required="required">
                                </asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"
                                    Rows="2" placeholder="Street address"></asp:TextBox>
                            </div>

                            <div class="row">
                                <div class="col col-6">
                                    <div class="form-group">
                                        <label class="form-label">City</label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"
                                            placeholder="City"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col col-6">
                                    <div class="form-group">
                                        <label class="form-label">State</label>
                                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control"
                                            placeholder="State"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Pin Code</label>
                                <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control"
                                    placeholder="6-digit PIN" MaxLength="6"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary"
                                    style="width: 100%; padding: 14px;" OnClick="btnRegister_Click" />
                            </div>

                            <div class="text-center">
                                <p>Already have an account? <a href="Login.aspx">Login here</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Content>