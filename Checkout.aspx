<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <h2>Checkout</h2>

                <div class="row">
                    <div class="col col-8">
                        <div class="card">
                            <h3>Delivery Information</h3>

                            <div class="form-group">
                                <label class="form-label">Delivery Address *</label>
                                <asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="form-control"
                                    TextMode="MultiLine" Rows="2" required="required"></asp:TextBox>
                            </div>

                            <div class="row">
                                <div class="col col-6">
                                    <div class="form-group">
                                        <label class="form-label">City *</label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"
                                            required="required"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col col-6">
                                    <div class="form-group">
                                        <label class="form-label">State *</label>
                                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control"
                                            required="required"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Pin Code *</label>
                                <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control" MaxLength="6"
                                    required="required"></asp:TextBox>
                            </div>

                            <hr />
                            <h3>Payment Method</h3>

                            <div class="form-group">
                                <asp:RadioButtonList ID="rblPaymentMethod" runat="server" CssClass="payment-methods">
                                    <asp:ListItem Text="Credit/Debit Card" Value="Card" Selected="True">
                                    </asp:ListItem>
                                    <asp:ListItem Text="Net Banking" Value="NetBanking"></asp:ListItem>
                                    <asp:ListItem Text="UPI" Value="UPI"></asp:ListItem>
                                    <asp:ListItem Text="Cash on Delivery" Value="COD"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Special Instructions (Optional)</label>
                                <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine"
                                    Rows="2" placeholder="Any special delivery instructions"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="col col-4">
                        <div class="card">
                            <h3>Order Summary</h3>
                            <hr />

                            <asp:Repeater ID="rptOrderItems" runat="server">
                                <ItemTemplate>
                                    <div
                                        style="display: flex; justify-content: space-between; margin-bottom: 0.75rem; padding-bottom: 0.75rem; border-bottom: 1px solid #f0f0f0;">
                                        <div>
                                            <strong>
                                                <%# Eval("ProductName") %>
                                            </strong><br />
                                            <small>Qty: <%# Eval("Quantity") %> × Rs. <%# Eval("Price", "{0:N2}" ) %>
                                                        </small>
                                        </div>
                                        <strong>Rs. <%# (Convert.ToDecimal(Eval("Price")) *
                                                Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></strong>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

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
                                <span>Delivery:</span>
                                <strong>Rs. <asp:Label ID="lblDeliveryCharges" runat="server"></asp:Label></strong>
                            </div>

                            <hr />

                            <div style="display: flex; justify-content: space-between; margin-bottom: 1.5rem;">
                                <span style="font-size: 1.2rem;">Grand Total:</span>
                                <strong style="font-size: 1.5rem; color: var(--primary-color);">Rs. <asp:Label
                                        ID="lblGrandTotal" runat="server"></asp:Label></strong>
                            </div>

                            <asp:LinkButton ID="btnPlaceOrder" runat="server" CssClass="btn btn-primary"
                                style="width: 100%; padding: 14px; display: block; text-align: center;"
                                OnClick="btnPlaceOrder_Click">
                                Place Order
                            </asp:LinkButton>

                            <a href="Cart.aspx" class="btn btn-outline"
                                style="width: 100%; margin-top: 1rem; display: block; text-align: center;">
                                Back to Cart
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <style>
            .payment-methods label {
                display: block;
                padding: 1rem;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                margin-bottom: 0.5rem;
                cursor: pointer;
                transition: var(--transition);
            }

            .payment-methods label:hover {
                border-color: var(--primary-color);
                background: rgba(0, 150, 214, 0.05);
            }

            .payment-methods input[type="radio"]:checked+label {
                border-color: var(--primary-color);
                background: rgba(0, 150, 214, 0.1);
            }
        </style>
    </asp:Content>