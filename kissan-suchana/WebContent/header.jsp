<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Header</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap & Fonts -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<!-- Scripts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- Custom CSS -->
<style>
body {
    font-family: 'Poppins', sans-serif;
    background-color: #fdfdfd;
    margin: 0;
    padding: 0;
}

/* Header */
.container-fluid.text-center {
    background-color: #FFD700;
    padding: 25px 20px 20px;
    color: #4e342e;
    border-radius: 0 0 20px 20px;
    position: relative;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    animation: slideFadeIn 1.2s ease-out;
}

@keyframes slideFadeIn {
    0% {
        opacity: 0;
        transform: translateY(-30px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

.container-fluid.text-center h2 {
    font-family: 'Playfair Display', serif;
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 8px;
    color: #33691e;
}

.container-fluid.text-center h6 {
    font-size: 16px;
    font-weight: 400;
    margin-bottom: 15px;
    color: #5d4037;
}

.form-inline .input-group {
    max-width: 450px;
    margin: auto;
}

.input-group .form-control {
    border-radius: 25px 0 0 25px;
    border: 1px solid #ffffff;
    height: 42px;
    font-size: 14px;
    padding-left: 15px;
    background-color: #ffffff;
    color: #333;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.input-group .btn-danger {
    border-radius: 0 25px 25px 0;
    background: linear-gradient(45deg, #cddc39, #aed581);
    border: none;
    font-weight: bold;
    padding: 10px 22px;
    color: #333;
    transition: all 0.3s ease;
}

.input-group .btn-danger:hover {
    background: #d4e157;
    color: #212121;
    box-shadow: 0 4px 10px rgba(158, 157, 36, 0.4);
}

#message {
    color: #33691e;
    font-weight: bold;
    margin-top: 10px;
    font-size: 14px;
}

/* Optional: Navbar Improvements */
.navbar-default {
    background: #ffffff;
    border: none;
    border-bottom: 2px solid #cddc39;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
}

.navbar-brand {
    font-weight: bold;
    font-size: 20px;
    color: #33691e !important;
}

.navbar-nav > li > a {
    font-weight: 600;
    padding: 12px 18px;
    color: #333 !important;
    border-radius: 20px;
    transition: all 0.3s ease;
}

.navbar-nav > li > a:hover,
.navbar-nav > li > a:focus {
    background: #f0f4c3;
    color: #33691e !important;
}

/* Responsive */
@media (max-width: 768px) {
    .container-fluid.text-center h2 {
        font-size: 24px;
    }
    .container-fluid.text-center h6 {
        font-size: 14px;
    }
}
</style>
</head>
<body>

<!-- Header -->
<div class="container-fluid text-center" style="margin-top: 45px;">
    <h2>Agriculture Products</h2>
    <h6>We have specialized in quality and care</h6>
    <p style="font-style: italic; font-size: 15px; color: #33691e;">"To plant a seed is to believe in tomorrow."</p>
    <p style="font-size: 14px; color: #5d4037;">Empowering Farmers with Trusted Products and Real-time Information.</p>
    <form class="form-inline" action="index.jsp" method="get">
        <div class="input-group">
            <input type="text" class="form-control" size="50" name="search" placeholder="Search Items" required>
            <div class="input-group-btn">
                <input type="submit" class="btn btn-danger" value="Search" />
            </div>
        </div>
    </form>
    <p id="message"></p>
</div>

<!-- Rest of your page continues... -->

<%
String userType = (String) session.getAttribute("usertype");
if (userType == null) {
%>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;KISAN SUCHANA</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="index.jsp">Products</a></li>
                <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="index.jsp?type=mobile">Pesticides</a></li>
                        <li><a href="index.jsp?type=tv">Fertilizers</a></li>
                        <li><a href="index.jsp?type=laptop">Market Rates</a></li>
                        <li><a href="index.jsp?type=camera">Organic Pesticides</a></li>
                        <li><a href="index.jsp?type=speaker">Travelling Goods</a></li>
                        <li><a href="index.jsp?type=tablet">Customer</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<% } else if ("customer".equalsIgnoreCase(userType)) {
int notf = new CartServiceImpl().getCartCount((String) session.getAttribute("username"));
%>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="userHome.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;KISAN SUCHANA</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="userHome.jsp">Products</a></li>
                <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="userHome.jsp?type=mobile">Pesticides</a></li>
                        <li><a href="userHome.jsp?type=tv">Fertilizers</a></li>
                        <li><a href="userHome.jsp?type=laptop">Market Rates</a></li>
                        <li><a href="userHome.jsp?type=camera">Organic Pesticides</a></li>
                        <li><a href="userHome.jsp?type=speaker">Travelling Goods</a></li>
                        <li><a href="userHome.jsp?type=tablet">Customer</a></li>
                    </ul>
                </li>
                <% if (notf == 0) { %>
                    <li><a href="cartDetails.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
                <% } else { %>
                    <li><a href="cartDetails.jsp" id="mycart"><i class="fa fa-shopping-cart fa-3x icon-white" data-count="<%=notf%>"></i></a></li>
                <% } %>
                <li><a href="orderDetails.jsp">Orders</a></li>
                <li><a href="userProfile.jsp">Profile</a></li>
                <li><a href="./LogoutSrv">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>
<% } else { %>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="adminViewProduct.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;KISAN SUCHANA</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="adminViewProduct.jsp">Products</a></li>
                <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="adminViewProduct.jsp?type=mobile">Pesticides</a></li>
                        <li><a href="adminViewProduct.jsp?type=tv">Fertilizers</a></li>
                        <li><a href="adminViewProduct.jsp?type=laptop">Market Rates</a></li>
                        <li><a href="adminViewProduct.jsp?type=camera">Organic Pesticides</a></li>
                        <li><a href="adminViewProduct.jsp?type=speaker">Travelling Goods</a></li>
                        <li><a href="adminViewProduct.jsp?type=tablet">Customer</a></li>
                    </ul>
                </li>
                <li><a href="adminStock.jsp">Stock</a></li>
                <li><a href="shippedItems.jsp">Shipped</a></li>
                <li><a href="unshippedItems.jsp">Orders</a></li>
                <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Update Items <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="addProduct.jsp">Add Product</a></li>
                        <li><a href="removeProduct.jsp">Remove Product</a></li>
                        <li><a href="updateProductById.jsp">Update Product</a></li>
                    </ul>
                </li>
                <li><a href="./LogoutSrv">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>
<% } %>
</body>
</html>
