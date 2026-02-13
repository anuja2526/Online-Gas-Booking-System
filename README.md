# 🔥 HP Gas Booking System

<div align="center">

![ASP.NET](https://img.shields.io/badge/ASP.NET-Web%20Forms-5C2D91?style=for-the-badge&logo=.net&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)

**A modern, full-featured web application for LPG gas cylinder booking and management**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Screenshots](#-screenshots) • [Documentation](#-documentation)

</div>

---
<center><img src="Screenshot 2026-02-13 155436.png"></center>

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Installation](#-installation)
- [Database Setup](#-database-setup)
- [Project Structure](#-project-structure)
- [Usage](#-usage)
- [Admin Panel](#-admin-panel)
- [API Reference](#-api-reference)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

The **HP Gas Booking System** is a comprehensive web-based platform that streamlines the process of ordering LPG gas cylinders online. Built with ASP.NET Web Forms and SQL Server, it provides a seamless experience for both customers and administrators.

### Why This Project?

- 🚀 **Modern UI/UX** - Clean, responsive design with glassmorphism effects
- 🔐 **Secure Authentication** - SHA256 password hashing
- 📊 **Rich Admin Dashboard** - Complete analytics and management tools
- 📱 **Mobile Responsive** - Works flawlessly on all devices
- 🛒 **Full E-commerce Flow** - From browsing to checkout
- 📈 **Real-time Analytics** - Track orders, revenue, and user statistics

---

## ✨ Features

### 🌐 Customer Features

| Feature | Description |
|---------|-------------|
| 🔑 **User Registration** | Secure account creation with email validation |
| 🔐 **Login/Logout** | Protected sessions with SHA256 encryption |
| 🛍️ **Product Catalog** | Browse gas cylinders with detailed specifications |
| 🔍 **Product Details** | View comprehensive product information |
| 🛒 **Shopping Cart** | Add, update, and remove items easily |
| 💳 **Checkout** | Streamlined order placement |
| 📦 **Order History** | Track all past and current orders |
| 👤 **Profile Management** | Update personal information and addresses |

### 🎛️ Admin Features

| Feature | Description |
|---------|-------------|
| 📊 **Analytics Dashboard** | Real-time business metrics and KPIs |
| 📦 **Product Management** | Add, edit, delete gas cylinder products |
| 📋 **Order Management** | View, filter, and update order statuses |
| 👥 **User Management** | Search, filter, activate/deactivate accounts |
| 📈 **Sales Reports** | Date-filtered analytics with multiple views |
| 💰 **Revenue Tracking** | Monitor total revenue and average order values |
| 🔍 **Advanced Filtering** | Filter by status, date range, and more |

---

## 🛠️ Tech Stack

### Frontend
```text
├── HTML5 - Semantic markup
├── CSS3 - Modern styling with glassmorphism
├── JavaScript - Client-side interactivity
└── Bootstrap Grid - Responsive layout system
```

### Backend
```text
├── ASP.NET Web Forms (.NET Framework 4.x)
├── C# - Server-side logic
├── ADO.NET - Database operations
└── Master Pages - Consistent layout
```

### Database
```text
└── Microsoft SQL Server
    ├── Stored Procedures
    ├── Views for reporting
    └── Triggers for automation
```

---

## 🚀 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

- **Visual Studio 2012** or later (Community Edition works)
- **SQL Server 2012** or later (Express Edition works)
- **SQL Server Management Studio (SSMS)** - Optional but recommended
- **.NET Framework 4.0** or later

### Step-by-Step Guide

#### 1️⃣ Clone the Repository

```bash
git clone https://github.com/yourusername/hp-gas-booking-system.git
cd hp-gas-booking-system
```

#### 2️⃣ Open in Visual Studio

1. Launch **Visual Studio 2012**
2. Click **File** → **Open** → **Web Site**
3. Navigate to `GasBooking` folder and select it
4. Wait for the solution to load

#### 3️⃣ Configure Connection String

Open `Web.config` and update the connection string:

```xml
<connectionStrings>
    <add name="HPGasConnectionString" 
         connectionString="Data Source=YOUR_SERVER_NAME\SQLEXPRESS;Initial Catalog=HPGasBookingDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

Replace `YOUR_SERVER_NAME` with your SQL Server instance name.

---

## 💾 Database Setup

### Automatic Setup (Recommended)

1. Open **SQL Server Management Studio**
2. Connect to your SQL Server instance
3. Open the file: `Database/DatabaseSchema.sql`
4. Execute the script (F5)

This will:
- ✅ Create the `HPGasBookingDB` database
- ✅ Create all required tables
- ✅ Insert default admin account
- ✅ Insert sample products
- ✅ Create stored procedures and views

### Default Admin Credentials

```text
Username: admin
Password: admin123
```

⚠️ **Important:** Change the admin password after first login!

### Database Schema

```text
HPGasBookingDB
├── Users (CustomerID, FullName, Email, Password, ...)
├── Admin (AdminID, Username, Password, Role, ...)
├── GasProducts (ProductID, ProductName, Price, Stock, ...)
├── Bookings (BookingID, CustomerID, OrderNumber, Status, ...)
├── BookingDetails (DetailID, BookingID, ProductID, Quantity, ...)
└── Views
    └── vw_DashboardStats (Aggregated statistics)
```

---

## 📁 Project Structure

```text
GasBooking/
│
├── 📂 Admin/                      # Admin panel pages
│   ├── AdminLogin.aspx           # Admin authentication
│   ├── Dashboard.aspx            # Analytics dashboard
│   ├── ManageProducts.aspx       # Product CRUD operations
│   ├── ManageOrders.aspx         # Order management
│   ├── ManageUsers.aspx          # User management
│   ├── Reports.aspx              # Sales analytics
│   └── DatabaseCheck.aspx        # DB diagnostic tool
│
├── 📂 MasterPages/                # Layout templates
│   ├── Site.master              # Customer site master
│   └── Admin.master             # Admin panel master
│
├── 📂 css/                        # Stylesheets
│   ├── styles.css               # Main customer styles
│   └── admin.css                # Admin panel styles
│
├── 📂 images/                     # Static images
│   └── (product images, logos)
│
├── 📂 App_Code/                   # C# helper classes
│   └── DBHelper.cs              # Database utility methods
│
├── 📂 Database/                   # Database scripts
│   └── DatabaseSchema.sql       # Complete DB setup script
│
├── 🏠 Default.aspx                # Homepage
├── 🔐 Login.aspx                  # Customer login
├── 📝 Register.aspx               # Customer registration
├── 🛍️ Products.aspx               # Product catalog
├── 📄 ProductDetails.aspx         # Product detail page
├── 🛒 Cart.aspx                   # Shopping cart
├── 💳 Checkout.aspx               # Order checkout
├── 📦 MyOrders.aspx               # Order history
├── 👤 Profile.aspx                # User profile
└── ⚙️ Web.config                  # Application configuration
```

---

## 🎮 Usage

### For Customers

1. **Browse Products**
   - Navigate to the homepage
   - Click "Products" to view all available cylinders
   - Use search and filters to find specific products

2. **Place an Order**
   ```text
   Register/Login → Browse Products → Add to Cart → Checkout → Confirm Order
   ```

3. **Track Orders**
   - Go to "My Orders" from the navigation menu
   - View order status (Pending/Processing/Completed/Cancelled)
   - Check delivery details

4. **Manage Profile**
   - Update personal information
   - Change delivery addresses
   - Update contact details

### For Administrators

1. **Login to Admin Panel**
   - Navigate to `/Admin/AdminLogin.aspx`
   - Use admin credentials

2. **Dashboard Overview**
   - View key metrics (Total Orders, Revenue, Users)
   - Check pending orders
   - Monitor recent activities

3. **Manage Products**
   - Add new gas cylinder products
   - Update prices and stock levels
   - Deactivate out-of-stock items

4. **Process Orders**
   - Filter orders by status
   - View detailed order information
   - Update order status

5. **View Reports**
   - Select date ranges
   - Analyze sales trends
   - Export data (future feature)

---

## 🎨 Screenshots

### Customer Interface

#### 🏠 Homepage
Clean, modern landing page with featured products and call-to-action buttons.

#### 🛍️ Product Catalog
Responsive grid layout showing all available gas cylinders with prices and details.

#### 🛒 Shopping Cart
Easy-to-use cart with quantity adjustments and real-time total calculations.

### Admin Panel

#### 📊 Dashboard
Beautiful analytics dashboard with gradient cards and real-time statistics.

#### 📋 Order Management
Comprehensive order view with filtering, status updates, and detailed information.

#### 📈 Reports & Analytics
Date-filtered reports with sales trends, top products, and revenue breakdowns.

---

## 🔐 Security Features

- ✅ **SHA256 Password Hashing** - Secure credential storage
- ✅ **Session Management** - Protected routes and authentication
- ✅ **SQL Parameterization** - Prevention against SQL injection
- ✅ **Input Validation** - Client and server-side validation
- ✅ **Role-based Access** - Separate customer and admin areas

---

## 📊 API Reference

### DBHelper Class

The `DBHelper` class provides database utility methods:

```csharp
// Execute a query and return DataTable
DataTable ExecuteQuery(string query, SqlParameter[] parameters)

// Execute non-query (INSERT, UPDATE, DELETE)
int ExecuteNonQuery(string query, SqlParameter[] parameters)

// Execute stored procedure
DataTable ExecuteStoredProcedure(string procedureName, SqlParameter[] parameters)

// Hash password with SHA256
string HashPassword(string password)
```

### Example Usage

```csharp
// Fetching products
string query = "SELECT * FROM GasProducts WHERE IsActive = @IsActive";
SqlParameter[] parameters = new SqlParameter[] {
    new SqlParameter("@IsActive", true)
};
DataTable products = DBHelper.ExecuteQuery(query, parameters);

// Hashing password
string hashedPassword = DBHelper.HashPassword("myPassword123");
```

---

## 🎯 Key Highlights

### Responsive Design
```css
/* Mobile-first approach */
@media (max-width: 480px) { ... }  /* Mobile */
@media (max-width: 768px) { ... }  /* Tablet */
/* Desktop styles by default */
```

### Modern UI Elements
- 🌈 Gradient backgrounds
- 💎 Glassmorphism effects
- ✨ Smooth transitions
- 🎭 Hover animations
- 📱 Touch-friendly buttons

---

## 🐛 Troubleshooting

### Common Issues

**Issue: "Login failed for user"**
```text
Solution: Check your connection string in Web.config
Ensure SQL Server is running and accepting connections
```

**Issue: "Invalid column name 'UserID'"**
```text
Solution: Database uses CustomerID, not UserID
All code has been updated to use correct column names
```

**Issue: "No data showing in admin pages"**
```text
Solution: 
1. Navigate to /Admin/DatabaseCheck.aspx
2. Click "Run Database Check"
3. Verify tables have data
4. Create test orders if needed
```

---

## 🚧 Future Enhancements

- [ ] Payment gateway integration (Razorpay/Stripe)
- [ ] Email notifications for orders
- [ ] SMS notifications
- [ ] PDF invoice generation
- [ ] Excel export for reports
- [ ] Real-time order tracking
- [ ] Customer reviews and ratings
- [ ] Loyalty points system
- [ ] Multi-language support
- [ ] Mobile app (React Native)

---

## 👥 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```text
MIT License

Copyright (c) 2026 HP Gas Booking System

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 👨‍💻 Developer

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- **Microsoft** - For ASP.NET framework
- **Bootstrap Team** - For the responsive grid system
- **Font Awesome** - For icons (if used)
- **SQL Server Team** - For the robust database engine

---

## 📞 Support

Need help? Here's how to get support:

- 📧 **Email**: support@hpgasbooking.com
- 💬 **Issues**: [GitHub Issues](https://github.com/yourusername/hp-gas-booking-system/issues)
- 📖 **Documentation**: Check the `/docs` folder
- 💡 **FAQ**: See common questions below

---

## ❓ FAQ

**Q: Can I use this for production?**  
A: Yes, but ensure you implement additional security measures and testing.

**Q: Does it support multiple payment methods?**  
A: Currently, it's a booking system. Payment integration is a future enhancement.

**Q: Can I modify the design?**  
A: Absolutely! The CSS is well-organized for easy customization.

**Q: Is there mobile app support?**  
A: Not yet, but the web app is fully responsive and mobile-friendly.

---

## 📈 Statistics

- **Total Lines of Code**: ~5,000+
- **Number of Pages**: 20+
- **Database Tables**: 5
- **Admin Features**: 7
- **Customer Features**: 8

---

<div align="center">

### ⭐ Star this repository if you found it helpful!

Made with ❤️ for the LPG Gas Booking Industry

**[⬆ back to top](#-hp-gas-booking-system)**

</div>
