<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col col-5">
                        <div class="card">
                            <asp:Image ID="imgProduct" runat="server" CssClass="card-img"
                                style="width: 100%; border-radius: var(--border-radius);" />
                        </div>
                    </div>

                    <div class="col col-7">
                        <div class="card">
                            <h2>
                                <asp:Label ID="lblProductName" runat="server"></asp:Label>
                            </h2>
                            <p class="text-light">
                                <asp:Label ID="lblBrand" runat="server"></asp:Label>
                            </p>

                            <div style="display: flex; gap: 1rem; margin: 1.5rem 0;">
                                <span class="badge badge-primary">
                                    <asp:Label ID="lblCategory" runat="server"></asp:Label>
                                </span>
                                <span class="badge badge-success">
                                    <asp:Label ID="lblWeight" runat="server"></asp:Label>
                                </span>
                                <asp:Label ID="lblStockBadge" runat="server" CssClass="badge"></asp:Label>
                            </div>

                            <div class="card-price" style="font-size: 2.5rem; margin: 1.5rem 0;">
                                Rs. <asp:Label ID="lblPrice" runat="server"></asp:Label>
                            </div>

                            <hr />

                            <h3>Description</h3>
                            <p>
                                <asp:Label ID="lblDescription" runat="server"></asp:Label>
                            </p>

                            <hr />

                            <div style="display: flex; align-items: center; gap: 1rem; margin-top: 2rem;">
                                <div class="form-group" style="flex: 0 0 120px; margin: 0;">
                                    <label class="form-label">Quantity</label>
                                    <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number"
                                        CssClass="form-control" Value="1" min="1" max="10"></asp:TextBox>
                                </div>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                                    CssClass="btn btn-primary btn-lg" style="flex: 1; margin-top: 1.8rem;"
                                    OnClick="btnAddToCart_Click" />
                            </div>

                            <a href="Products.aspx" class="btn btn-outline"
                                style="width: 100%; margin-top: 1rem; display: block; text-align: center;">
                                Back to Products
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Additional Product Details -->
                <div class="row" style="margin-top: 2rem;">
                    <div class="col col-12">
                        <div class="card">
                            <h3>Product Specifications</h3>
                            <table class="table">
                                <tr>
                                    <td><strong>Brand</strong></td>
                                    <td>
                                        <asp:Label ID="lblBrandDetail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Weight</strong></td>
                                    <td>
                                        <asp:Label ID="lblWeightDetail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Category</strong></td>
                                    <td>
                                        <asp:Label ID="lblCategoryDetail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Stock Status</strong></td>
                                    <td>
                                        <asp:Label ID="lblStockStatus" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Price</strong></td>
                                    <td>Rs. <asp:Label ID="lblPriceDetail" runat="server"></asp:Label>
                                    </td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </asp:Content>