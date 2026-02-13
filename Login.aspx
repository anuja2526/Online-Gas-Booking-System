<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col col-4" style="margin: 0 auto;">
                        <div class="card fade-in">
                            <h2 class="text-center">Welcome Back</h2>
                            <p class="text-center text-light mb-4">Login to your account</p>

                            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mb-3"></asp:Panel>

                            <div class="form-group">
                                <label class="form-label">Email Address<asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
                                </label>
                                &nbsp;<asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"
                                    placeholder="your.email@example.com" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"
                                    placeholder="Enter your password" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary"
                                    style="width: 100%; padding: 14px;" OnClick="btnLogin_Click" />
                            </div>

                            <div class="text-center">
                                <p>Don't have an account? <a href="Register.aspx">Register here</a></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Content>