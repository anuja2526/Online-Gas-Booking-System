<%@ Page Title="Shopping Cart" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Cart.aspx.cs" Inherits="Cart" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <h2>Shopping Cart</h2>

                <asp:Panel ID="pnlCart" runat="server" Visible="false">
                    <div class="row">
                        <div class="col col-8">
                            <div class="card">
                                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" CssClass="table"
                                    OnRowCommand="gvCart_RowCommand" DataKeyNames="CartID">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Product">
                                            <ItemTemplate>
                                                <div style="display: flex; align-items: center; gap: 1rem;">
                                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>'
                                                        style="width: 80px; height: 80px; object-fit: cover; border-radius: 8px;"
                                                        onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%2280%22 height=%2280%22%3E%3Crect fill=%22%23f0f0f0%22 width=%2280%22 height=%2280%22/%3E%3C/svg%3E';" />
                                                    <div>
                                                        <strong>
                                                            <%# Eval("ProductName") %>
                                                        </strong><br />
                                                        <small>
                                                            <%# Eval("Weight") %>
                                                                <%# Eval("WeightUnit") %>
                                                        </small>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Price">
                                            <ItemTemplate>
                                                Rs. <%# Eval("Price", "{0:N2}" ) %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Quantity">
                                            <ItemTemplate>
                                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                                    <asp:LinkButton ID="btnDecrease" runat="server"
                                                        CommandName="UpdateQuantity"
                                                        CommandArgument='<%# Eval("CartID") + ",-1" %>'
                                                        CssClass="btn btn-outline" style="padding: 0.25rem 0.75rem;">-
                                                    </asp:LinkButton>
                                                    <span style="min-width: 30px; text-align: center;"><strong>
                                                            <%# Eval("Quantity") %>
                                                        </strong></span>
                                                    <asp:LinkButton ID="btnIncrease" runat="server"
                                                        CommandName="UpdateQuantity"
                                                        CommandArgument='<%# Eval("CartID") + ",1" %>'
                                                        CssClass="btn btn-outline" style="padding: 0.25rem 0.75rem;">+
                                                    </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Total">
                                            <ItemTemplate>
                                                <strong>Rs. <%# (Convert.ToDecimal(Eval("Price")) *
                                                        Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></strong>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveItem"
                                                    CommandArgument='<%# Eval("CartID") %>'
                                                    CssClass="btn btn-danger btn-sm"
                                                    OnClientClick="return confirm('Remove this item from cart?');">
                                                    &times; Remove
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                        <div class="col col-4">
                            <div class="card">
                                <h3>Order Summary</h3>
                                <hr />

                                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                    <span>Subtotal:</span>
                                    <strong>Rs. <asp:Label ID="lblSubtotal" runat="server"></asp:Label></strong>
                                </div>

                                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                    <span>Tax (5%):</span>
                                    <strong>Rs. <asp:Label ID="lblTax" runat="server"></asp:Label></strong>
                                </div>

                                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                    <span>Delivery Charges:</span>
                                    <strong>Rs. <asp:Label ID="lblDeliveryCharges" runat="server"></asp:Label></strong>
                                </div>

                                <hr />

                                <div style="display: flex; justify-content: space-between; margin-bottom: 1.5rem;">
                                    <span style="font-size: 1.2rem;">Grand Total:</span>
                                    <strong style="font-size: 1.5rem; color: var(--primary-color);">Rs. <asp:Label
                                            ID="lblGrandTotal" runat="server"></asp:Label></strong>
                                </div>

                                <asp:LinkButton ID="btnCheckout" runat="server" CssClass="btn btn-primary"
                                    style="width: 100%; padding: 14px;" OnClick="btnCheckout_Click">
                                    Proceed to Checkout
                                </asp:LinkButton>

                                <a href="Products.aspx" class="btn btn-outline"
                                    style="width: 100%; margin-top: 1rem; display: block; text-align: center;">
                                    Continue Shopping
                                </a>
                            </div>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="text-center"
                    style="padding: 5rem 0;">
                    <div style="font-size: 3rem; font-weight: bold; color: #ccc;">EMPTY CART</div>
                    <h3>Your cart is empty</h3>
                    <p>Add some products to get started</p>
                    <a href="Products.aspx" class="btn btn-primary btn-lg" style="margin-top: 2rem;">Browse Products</a>
                </asp:Panel>
            </div>
        </section>
    </asp:Content>