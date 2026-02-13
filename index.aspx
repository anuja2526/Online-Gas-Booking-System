<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeFile="index.aspx.cs" Inherits="_Default" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <!-- Hero Section -->
        <section class="hero">
            <div class="container">
                <div class="hero-content">
                    <h1>Welcome to HP Gas Booking</h1>
                    <p>Get your gas cylinder delivered to your doorstep - Safe, Fast & Reliable</p>
                    <div style="margin-top: 2rem;">
                        <a href="Products.aspx" class="btn btn-outline btn-lg" style="margin-right: 1rem;">Browse
                            Products</a>
                        <a href="Register.aspx" class="btn btn-secondary btn-lg">Get Started</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="section">
            <div class="container">
                <div class="section-title">
                    <h2>Why Choose HP Gas</h2>
                    <p>Experience the best in gas cylinder booking and delivery</p>
                </div>

                <div class="row">
                    <div class="col col-4">
                        <div class="card slide-up">
                            <div
                                style="font-size: 2rem; text-align: center; color: var(--primary-color); font-weight: bold;">
                                SAFE</div>
                            <h3 class="card-title text-center">Safe & Secure</h3>
                            <p class="card-text text-center">
                                All our gas cylinders undergo rigorous safety checks before delivery to ensure your
                                family's safety.
                            </p>
                        </div>
                    </div>

                    <div class="col col-4">
                        <div class="card slide-up" style="animation-delay: 0.1s;">
                            <div
                                style="font-size: 2rem; text-align: center; color: var(--primary-color); font-weight: bold;">
                                DELIVERY</div>
                            <h3 class="card-title text-center">Fast Delivery</h3>
                            <p class="card-text text-center">
                                Get your gas cylinder delivered within 24-48 hours right at your doorstep.
                            </p>
                        </div>
                    </div>

                    <div class="col col-4">
                        <div class="card slide-up" style="animation-delay: 0.2s;">
                            <div
                                style="font-size: 2rem; text-align: center; color: var(--primary-color); font-weight: bold;">
                                ₹ PRICE</div>
                            <h3 class="card-title text-center">Best Prices</h3>
                            <p class="card-text text-center">
                                Competitive pricing with no hidden charges. Pay only for what you get.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Products -->
        <section class="section" style="background: var(--white);">
            <div class="container">
                <div class="section-title">
                    <h2>Our Products</h2>
                    <p>Choose from our wide range of gas cylinders</p>
                </div>

                <div class="row">
                    <asp:Repeater ID="rptFeaturedProducts" runat="server">
                        <ItemTemplate>
                            <div class="col col-4">
                                <div class="card scale-in">
                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="card-img"
                                        onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22200%22%3E%3Crect fill=%22%23f0f0f0%22 width=%22300%22 height=%22200%22/%3E%3Ctext x=%2250%25%22 y=%2250%25%22 dominant-baseline=%22middle%22 text-anchor=%22middle%22 font-family=%22Arial%22 font-size=%2218%22 fill=%22%23999%22%3EProduct Image%3C/text%3E%3C/svg%3E';" />
                                    <h3 class="card-title">
                                        <%# Eval("ProductName") %>
                                    </h3>
                                    <p class="card-text">
                                        <%# Eval("Description") %>
                                    </p>
                                    <div class="card-price">Rs. <%# Eval("Price", "{0:N2}" ) %>
                                    </div>
                                    <span class="badge badge-success">
                                        <%# Eval("Weight") %>
                                            <%# Eval("WeightUnit") %>
                                    </span>
                                    <div style="margin-top: 1rem;">
                                        <a href='ProductDetails.aspx?id=<%# Eval("ProductID") %>'
                                            class="btn btn-primary" style="width: 100%;">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="text-center" style="margin-top: 2rem;">
                    <a href="Products.aspx" class="btn btn-primary btn-lg">View All Products</a>
                </div>
            </div>
        </section>

        <!-- How It Works -->
        <section class="section">
            <div class="container">
                <div class="section-title">
                    <h2>How It Works</h2>
                    <p>Simple steps to get your gas cylinder</p>
                </div>

                <div class="row">
                    <div class="col col-3">
                        <div class="text-center slide-up">
                            <div
                                style="width: 80px; height: 80px; background: var(--primary-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: var(--white); font-size: 2rem; font-weight: bold;">
                                1</div>
                            <h3>Register</h3>
                            <p>Create your account in minutes</p>
                        </div>
                    </div>
                    <div class="col col-3">
                        <div class="text-center slide-up" style="animation-delay: 0.1s;">
                            <div
                                style="width: 80px; height: 80px; background: var(--primary-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: var(--white); font-size: 2rem; font-weight: bold;">
                                2</div>
                            <h3>Choose</h3>
                            <p>Select your gas cylinder</p>
                        </div>
                    </div>
                    <div class="col col-3">
                        <div class="text-center slide-up" style="animation-delay: 0.2s;">
                            <div
                                style="width: 80px; height: 80px; background: var(--primary-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: var(--white); font-size: 2rem; font-weight: bold;">
                                3</div>
                            <h3>Pay</h3>
                            <p>Secure online payment</p>
                        </div>
                    </div>
                    <div class="col col-3">
                        <div class="text-center slide-up" style="animation-delay: 0.3s;">
                            <div
                                style="width: 80px; height: 80px; background: var(--primary-color); border-radius: 50%; margin: 0 auto 1rem; display: flex; align-items: center; justify-content: center; color: var(--white); font-size: 2rem; font-weight: bold;">
                                4</div>
                            <h3>Receive</h3>
                            <p>Get it delivered at home</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="section"
            style="background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%); color: var(--white);">
            <div class="container text-center">
                <h2 style="color: var(--white); margin-bottom: 1.5rem;">Ready to Book Your Gas Cylinder?</h2>
                <p style="font-size: 1.2rem; margin-bottom: 2rem;">Join thousands of satisfied customers across India
                </p>
                <a href="Register.aspx" class="btn btn-outline btn-lg">Register Now</a>
            </div>
        </section>
    </asp:Content>