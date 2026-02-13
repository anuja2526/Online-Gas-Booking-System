<%@ Page Title="Invoice" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Invoice.aspx.cs" Inherits="Invoice" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            @media print {

                .navbar,
                .footer,
                .no-print {
                    display: none !important;
                }

                body {
                    background: white !important;
                }
            }

            .invoice-header {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                padding: 2rem;
                border-radius: var(--border-radius) var(--border-radius) 0 0;
                text-align: center;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col col-8" style="margin: 0 auto;">
                        <div class="card" style="padding: 0; overflow: hidden;">
                            <div class="invoice-header">
                                <h1 style="color: white; margin: 0;">HP GAS</h1>
                                <p style="margin: 0.5rem 0 0; opacity: 0.9;">Tax Invoice</p>
                            </div>

                            <div style="padding: 2rem;">
                                <!-- Invoice Details -->
                                <div class="row" style="margin-bottom: 2rem;">
                                    <div class="col col-6">
                                        <strong>Invoice #:</strong>
                                        <asp:Label ID="lblInvoiceNumber" runat="server"></asp:Label><br />
                                        <strong>Date:</strong>
                                        <asp:Label ID="lblInvoiceDate" runat="server"></asp:Label><br />
                                        <strong>Status:</strong>
                                        <asp:Label ID="lblStatus" runat="server" CssClass="badge"></asp:Label>
                                    </div>
                                    <div class="col col-6 text-right">
                                        <strong>HP Gas Company</strong><br />
                                        Pan India Service<br />
                                        Phone: 1800-2233-555<br />
                                        Email: support@hpgas.com
                                    </div>
                                </div>

                                <!-- Customer Details -->
                                <div
                                    style="background: #f8f9fa; padding: 1.5rem; border-radius: var(--border-radius); margin-bottom: 2rem;">
                                    <strong>Bill To:</strong><br />
                                    <asp:Label ID="lblCustomerName" runat="server"></asp:Label><br />
                                    <asp:Label ID="lblCustomerAddress" runat="server"></asp:Label><br />
                                    <asp:Label ID="lblCustomerEmail" runat="server"></asp:Label><br />
                                    <asp:Label ID="lblCustomerPhone" runat="server"></asp:Label>
                                </div>

                                <!-- Order Items -->
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th class="text-center">Quantity</th>
                                            <th class="text-right">Unit Price</th>
                                            <th class="text-right">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptInvoiceItems" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <%# Eval("ProductName") %>
                                                    </td>
                                                    <td class="text-center">
                                                        <%# Eval("Quantity") %>
                                                    </td>
                                                    <td class="text-right">Rs. <%# Eval("UnitPrice", "{0:N2}" ) %>
                                                    </td>
                                                    </td>
                                                    <td class="text-right">Rs. <%# Eval("TotalPrice", "{0:N2}" ) %>
                                                    </td>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>

                                <!-- Totals -->
                                <div style="max-width: 400px; margin-left: auto;">
                                    <table style="width: 100%; margin-top: 1rem;">
                                        <tr>
                                            <td>Subtotal:</td>
                                            <td class="text-right"><strong>Rs. <asp:Label ID="lblSubtotal"
                                                        runat="server">
                                                    </asp:Label></strong></td>
                                        </tr>
                                        <tr>
                                            <td>Tax (5%):</td>
                                            <td class="text-right"><strong>Rs. <asp:Label ID="lblTax" runat="server">
                                                    </asp:Label></strong></td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Charges:</td>
                                            <td class="text-right"><strong>Rs. <asp:Label ID="lblDeliveryCharges"
                                                        runat="server"></asp:Label></strong></td>
                                        </tr>
                                        <tr style="border-top: 2px solid var(--primary-color); font-size: 1.2rem;">
                                            <td style="padding-top: 0.5rem;"><strong>Grand Total:</strong></td>
                                            <td class="text-right"
                                                style="padding-top: 0.5rem; color: var(--primary-color);"><strong>Rs.
                                                    <asp:Label ID="lblGrandTotal" runat="server"></asp:Label>
                                                </strong>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <!-- Payment Info -->
                                <div
                                    style="margin-top: 2rem; padding: 1rem; background: #f0f7ff; border-left: 4px solid var(--primary-color); border-radius: 4px;">
                                    <strong>Payment Information:</strong><br />
                                    Method: <asp:Label ID="lblPaymentMethod" runat="server"></asp:Label><br />
                                    Status: <asp:Label ID="lblPaymentStatus" runat="server"></asp:Label><br />
                                    Transaction ID: <asp:Label ID="lblTransactionID" runat="server"></asp:Label>
                                </div>

                                <!-- Delivery Info -->
                                <div
                                    style="margin-top: 1rem; padding: 1rem; background: #f0fff4; border-left: 4px solid var(--success); border-radius: 4px;">
                                    <strong>Delivery Address:</strong><br />
                                    <asp:Label ID="lblDeliveryAddress" runat="server"></asp:Label>
                                </div>

                                <!-- Footer -->
                                <div class="text-center"
                                    style="margin-top: 3rem; padding-top: 2rem; border-top: 1px solid #e0e0e0; color: var(--text-light);">
                                    <p>Thank you for your business!</p>
                                    <p style="font-size: 0.9rem;">For support, contact us at support@hpgas.com or call
                                        1800-2233-555</p>
                                </div>

                                <!-- Action Buttons -->
                                <div class="no-print text-center"
                                    style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #e0e0e0;">
                                    <button onclick="window.print();" class="btn btn-primary"
                                        style="margin-right: 1rem;">Print Invoice</button>
                                    <a href="UserDashboard.aspx" class="btn btn-outline">Back to Dashboard</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Content>