<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="UserDashboard.aspx.cs" Inherits="UserDashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <div
                    style="background: linear-gradient(135deg, var(--primary-color), var(--primary-dark)); padding: 2rem; border-radius: var(--border-radius); color: white; margin-bottom: 2rem;">
                    <h1 style="color: white; margin: 0; font-size: 2.5rem;">Welcome Back, <asp:Label
                            ID="lblCustomerName" runat="server"></asp:Label>!</h1>
                    <p style="margin: 0.5rem 0 0; opacity: 0.9; font-size: 1.1rem;">Ready to manage your gas bookings?
                        Let's get started.</p>
                </div>

                <!-- Quick Stats -->
                <div class="row" style="margin-top: 2rem;">
                    <div class="col col-4">
                        <div class="card scale-in"
                            style="background: linear-gradient(135deg, var(--primary-color), var(--primary-dark)); color: var(--white);">
                            <div style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: bold;">ORDERS</div>
                            <h3 style="color: var(--white); margin: 0;">
                                <asp:Label ID="lblTotalOrders" runat="server"></asp:Label>
                            </h3>
                            <p style="margin: 0; opacity: 0.9;">Total Orders</p>
                        </div>
                    </div>
                    <div class="col col-4">
                        <div class="card scale-in"
                            style="background: linear-gradient(135deg, var(--success), #00a078); color: var(--white); animation-delay: 0.1s;">
                            <div style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: bold;">PENDING</div>
                            <h3 style="color: var(--white); margin: 0;">
                                <asp:Label ID="lblPendingOrders" runat="server"></asp:Label>
                            </h3>
                            <p style="margin: 0; opacity: 0.9;">Pending Orders</p>
                        </div>
                    </div>
                    <div class="col col-4">
                        <div class="card scale-in"
                            style="background: linear-gradient(135deg, var(--secondary-color), #d45828); color: var(--white); animation-delay: 0.2s;">
                            <div style="font-size: 2.5rem; margin-bottom: 0.5rem; font-weight: bold;">SPENT</div>
                            <h3 style="color: var(--white); margin: 0;">
                                Rs. <asp:Label ID="lblTotalSpent" runat="server"></asp:Label>
                            </h3>
                            <p style="margin: 0; opacity: 0.9;">Total Amount</p>
                        </div>
                    </div>
                </div>

                <!-- Recent Orders -->
                <div style="margin-top: 3rem;">
                    <div
                        style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                        <h3>Recent Orders</h3>
                        <a href="OrderHistory.aspx" class="btn btn-outline">View All Orders</a>
                    </div>

                    <div class="card">
                        <asp:GridView ID="gvRecentOrders" runat="server" AutoGenerateColumns="false" CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="OrderNumber" HeaderText="Order #" />
                                <asp:BoundField DataField="BookingDate" HeaderText="Date"
                                    DataFormatString="{0:dd MMM yyyy}" />
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        Rs. <%# Eval("GrandTotal", "{0:N2}" ) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='badge badge-<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <a href='Invoice.aspx?id=<%# Eval("BookingID") %>' class="btn btn-outline"
                                            style="padding: 0.5rem 1rem;">View Invoice</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                        <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="text-center"
                            style="padding: 2rem;">
                            <p>No orders yet. <a href="Products.aspx">Start shopping</a></p>
                        </asp:Panel>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div style="margin-top: 3rem;">
                    <h3>Quick Actions</h3>
                    <div class="row" style="margin-top: 1rem;">
                        <div class="col col-3">
                            <a href="Products.aspx" class="card"
                                style="text-align: center; display: block; text-decoration: none;">
                                <div style="font-size: 2.5rem; color: var(--primary-color); font-weight: bold;">SHOP
                                </div>
                                <h4>Browse Products</h4>
                            </a>
                        </div>
                        <div class="col col-3">
                            <a href="Cart.aspx" class="card"
                                style="text-align: center; display: block; text-decoration: none;">
                                <div style="font-size: 2.5rem; color: var(--primary-color); font-weight: bold;">CART
                                </div>
                                <h4>View Cart</h4>
                            </a>
                        </div>
                        <div class="col col-3">
                            <a href="OrderHistory.aspx" class="card"
                                style="text-align: center; display: block; text-decoration: none;">
                                <div style="font-size: 2.5rem; color: var(--primary-color); font-weight: bold;">HISTORY
                                </div>
                                <h4>Order History</h4>
                            </a>
                        </div>
                        <div class="col col-3">
                            <a href="Profile.aspx" class="card"
                                style="text-align: center; display: block; text-decoration: none;">
                                <div style="font-size: 2.5rem; color: var(--primary-color); font-weight: bold;">PROFILE
                                </div>
                                <h4>My Profile</h4>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Content>