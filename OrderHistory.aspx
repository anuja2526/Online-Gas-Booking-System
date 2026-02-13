<%@ Page Title="Order History" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="OrderHistory.aspx.cs" Inherits="OrderHistory" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <h2>Order History</h2>
                <p class="text-light">View all your past orders and track their status</p>

                <div class="card" style="margin-top: 2rem;">
                    <asp:GridView ID="gvOrderHistory" runat="server" AutoGenerateColumns="false" CssClass="table">
                        <Columns>
                            <asp:BoundField DataField="OrderNumber" HeaderText="Order #" />
                            <asp:BoundField DataField="BookingDate" HeaderText="Order Date"
                                DataFormatString="{0:dd MMM yyyy HH:mm}" />
                            <asp:TemplateField HeaderText="Items">
                                <ItemTemplate>
                                    <%# Eval("ItemCount") %> item(s)
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="GrandTotal" HeaderText="Total Amount"
                                DataFormatString="Rs. {0:N2}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge badge-<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delivery">
                                <ItemTemplate>
                                    <%# Eval("DeliveryCity") %>, <%# Eval("DeliveryState") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <a href='Invoice.aspx?id=<%# Eval("BookingID") %>' class="btn btn-outline"
                                        style="padding: 0.5rem 1rem; margin-right: 0.5rem;">
                                        View Invoice
                                    </a>
                                    <asp:LinkButton ID="btnViewDetails" runat="server" CommandName="ViewDetails"
                                        CommandArgument='<%# Eval("BookingID") %>' CssClass="btn btn-primary"
                                        style="padding: 0.5rem 1rem;" OnCommand="btnViewDetails_Command">
                                        Details
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="text-center"
                        style="padding: 3rem;">
                        <h3>No orders yet</h3>
                        <p>You haven't placed any orders yet. Start shopping to see your order history here.</p>
                        <a href="Products.aspx" class="btn btn-primary btn-lg" style="margin-top: 1rem;">Browse
                            Products</a>
                    </asp:Panel>
                </div>

                <!-- Order Details Modal Panel -->
                <asp:Panel ID="pnlOrderDetails" runat="server" Visible="false" CssClass="card"
                    style="margin-top: 2rem; background: #f8f9fa;">
                    <h3>Order Details</h3>
                    <hr />

                    <div class="row">
                        <div class="col col-6">
                            <p><strong>Order Number:</strong>
                                <asp:Label ID="lblDetailOrderNumber" runat="server"></asp:Label>
                            </p>
                            <p><strong>Order Date:</strong>
                                <asp:Label ID="lblDetailOrderDate" runat="server"></asp:Label>
                            </p>
                            <p><strong>Status:</strong>
                                <asp:Label ID="lblDetailStatus" runat="server" CssClass="badge"></asp:Label>
                            </p>
                        </div>
                        <div class="col col-6">
                            <p><strong>Delivery Address:</strong></p>
                            <asp:Label ID="lblDetailDeliveryAddress" runat="server"></asp:Label>
                        </div>
                    </div>

                    <h4 style="margin-top: 1.5rem;">Items</h4>
                    <asp:Repeater ID="rptOrderItems" runat="server">
                        <ItemTemplate>
                            <div
                                style="display: flex; justify-content: space-between; padding: 1rem; background: white; border-radius: 8px; margin-bottom: 0.5rem;">
                                <div>
                                    <strong>
                                        <%# Eval("ProductName") %>
                                    </strong><br />
                                    <small>Quantity: <%# Eval("Quantity") %> × Rs. <%# Eval("UnitPrice", "{0:N2}" ) %>
                                                </small>
                                    </small>
                                </div>
                                <strong>Rs. <%# Eval("TotalPrice", "{0:N2}" ) %></strong>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div style="max-width: 400px; margin-left: auto; margin-top: 1.5rem;">
                        <table style="width: 100%;">
                            <tr>
                                <td>Subtotal:</td>
                                <td class="text-right"><strong>Rs. <asp:Label ID="lblDetailSubtotal" runat="server">
                                        </asp:Label></strong></td>
                            </tr>
                            <tr>
                                <td>Tax:</td>
                                <td class="text-right"><strong>Rs. <asp:Label ID="lblDetailTax" runat="server">
                                        </asp:Label>
                                    </strong></td>
                            </tr>
                            <tr>
                                <td>Delivery Charges:</td>
                                <td class="text-right"><strong>Rs. <asp:Label ID="lblDetailDelivery" runat="server">
                                        </asp:Label></strong></td>
                            </tr>
                            <tr style="border-top: 2px solid var(--primary-color); font-size: 1.2rem;">
                                <td style="padding-top: 0.5rem;"><strong>Grand Total:</strong></td>
                                <td class="text-right" style="padding-top: 0.5rem; color: var(--primary-color);">
                                    <strong>Rs. <asp:Label ID="lblDetailGrandTotal" runat="server"></asp:Label></strong>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <asp:Button ID="btnCloseDetails" runat="server" Text="Close" CssClass="btn btn-outline"
                        style="margin-top: 1.5rem;" OnClick="btnCloseDetails_Click" />
                </asp:Panel>
            </div>
        </section>
    </asp:Content>