<%@ Page Title="Products" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="Products.aspx.cs" Inherits="Products" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <section class="section">
            <div class="container">
                <div class="section-title">
                    <h2>Our Gas Products</h2>
                    <p>Choose from our wide range of gas cylinders</p>
                </div>

                <!-- Search and Filter -->
                <div class="card mb-4">
                    <div class="row">
                        <div class="col col-6">
                            <div class="form-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                    placeholder="Search products..." onkeyup="HPGas.filterProducts(this.value)">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="col col-6">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                    <asp:ListItem Text="All Categories" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Domestic" Value="Domestic"></asp:ListItem>
                                    <asp:ListItem Text="Commercial" Value="Commercial"></asp:ListItem>
                                    <asp:ListItem Text="Refill" Value="Refill"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products Grid -->
                <div class="row">
                    <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                        <ItemTemplate>
                            <div class="col col-4 product-card">
                                <div class="card scale-in" style="margin-bottom: 2rem;">
                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="card-img"
                                        onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22200%22%3E%3Crect fill=%22%23f0f0f0%22 width=%22300%22 height=%22200%22/%3E%3Ctext x=%2250%25%22 y=%2250%25%22 dominant-baseline=%22middle%22 text-anchor=%22middle%22 font-family=%22Arial%22 font-size=%2218%22 fill=%22%23999%22%3EProduct Image%3C/text%3E%3C/svg%3E';" />

                                    <h3 class="card-title">
                                        <%# Eval("ProductName") %>
                                    </h3>
                                    <p class="card-text">
                                        <%# Eval("Description") %>
                                    </p>

                                    <div
                                        style="display: flex; justify-content: space-between; align-items: center; margin: 1rem 0;">
                                        <span class="badge badge-primary">
                                            <%# Eval("Category") %>
                                        </span>
                                        <span class="badge badge-success">
                                            <%# Eval("Weight") %>
                                                <%# Eval("WeightUnit") %>
                                        </span>
                                    </div>

                                    <div class="card-price">Rs. <%# Eval("Price", "{0:N2}" ) %>
                                    </div>

                                    <div
                                        style="display: flex; justify-content: space-between; align-items: center; gap: 0.5rem; margin-top: 1rem;">
                                        <span class="badge <%# Convert.ToInt32(Eval(" Stock"))> 0 ? "badge-success" :
                                            "badge-danger" %>">
                                            <%# Convert.ToInt32(Eval("Stock"))> 0 ? "In Stock" : "Out of Stock" %>
                                        </span>
                                        <span style="font-size: 0.9rem; color: var(--text-light);">Stock: <%#
                                                Eval("Stock") %></span>
                                    </div>

                                    <div style="margin-top: 1rem; display: flex; gap: 0.5rem;">
                                        <a href='ProductDetails.aspx?id=<%# Eval("ProductID") %>'
                                            class="btn btn-outline" style="flex: 1;">View Details</a>
                                        <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="AddToCart"
                                            CommandArgument='<%# Eval("ProductID") %>' CssClass='btn btn-primary'
                                            Style="flex: 1;" Enabled='<%# Convert.ToInt32(Eval("Stock")) > 0 %>'>
                                            Add to Cart
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:Panel ID="pnlNoProducts" runat="server" Visible="false" CssClass="text-center"
                    style="padding: 3rem;">
                    <h3>No products found</h3>
                    <p>Try adjusting your search or filter criteria</p>
                </asp:Panel>
            </div>
        </section>
    </asp:Content>