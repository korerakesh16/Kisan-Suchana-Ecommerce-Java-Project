<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<!-- jQuery and Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- Custom Styling -->
<style>
    body {
        font-family: 'Quicksand', sans-serif;
        margin: 0;
        background: linear-gradient(270deg, #e6f7ff, #dff9fb, #e6f7ff);
        background-size: 600% 600%;
        animation: gradientBG 15s ease infinite;
    }

    @keyframes gradientBG {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    .text-center {
        font-size: 20px;
        font-weight: bold;
        color: #2c3e50;
        margin: 20px 0;
    }
    .form-container {
        margin-top: 30px;
        background-color: #e8fbe8;
        padding: 25px;
        border-radius: 20px;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        max-width: 550px; /* Reduced from 700px */
        margin-left: auto;
        margin-right: auto;
        transition: transform 0.3s ease;
        overflow: visible; /* Ensures dropdowns are fully visible */
    }

    .form-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 40px rgba(0, 0, 0, 0.15);
    }

    .form-container h2 {
        font-family: 'Poppins', sans-serif;
        font-size: 20px;
        font-weight: 500;
        color: #2ecc71;
        text-align: center;
        margin-bottom: 20px;
    }

    .form-group label {
        font-size: 16px;
        font-weight: 500;
        color: #333;
    }

    input.form-control,
    select.form-control,
    textarea.form-control {
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        border-radius: 15px;
        border: 1px solid #ccc;
        padding: 10px;
        color: #000000 !important;
        background-color: #ffffff !important;
    }

    input::placeholder,
    textarea::placeholder {
        color: #555555 !important;
        opacity: 2;
    }

    select.form-control {
        appearance: none;
        background-image: url("data:image/svg+xml;utf8,<svg fill='black' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
        background-repeat: no-repeat;
        background-position-x: 98%;
        background-position-y: 50%;
        padding-right: 2.5rem;
        overflow: visible;
    }

    .form-control:focus {
        border-color: #16a085;
        box-shadow: 0 0 5px rgba(22, 160, 133, 0.6);
    }

    .btn-danger, .btn-success {
        border-radius: 25px;
        padding: 10px 20px;
        font-size: 18px;
        font-weight: 500;
        transition: transform 0.3s ease, background-color 0.3s ease;
    }

    .btn-danger {
        background-color: #e74c3c;
        color: white;
    }

    .btn-danger:hover {
        background-color: #c0392b;
        transform: scale(1.05);
    }

    .btn-success {
        background-color: #2ecc71;
        color: white;
    }

    .btn-success:hover {
        background-color: #27ae60;
        transform: scale(1.05);
    }

    .header-buttons a, .header-buttons button {
        font-family: 'Rubik', sans-serif;
        font-weight: 600;
        color: white !important;
        background-color: #2c3e50;
        margin: 5px;
        padding: 8px 20px;
        border-radius: 30px;
        transition: 0.3s ease-in-out;
        text-transform: uppercase;
    }

    .header-buttons a:hover, .header-buttons button:hover {
        background-color: #1abc9c !important;
        color: #fff !important;
        transform: scale(1.05);
    }
</style>
</head>
<body>
<%
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }
%>

<jsp:include page="header.jsp" />

<%
    String message = request.getParameter("message");
%>

<div class="container">
    <div class="form-container">
        <form action="./AddProductSrv" method="post" enctype="multipart/form-data">
            <div class="text-center">
                <h2>Products Adding </h2>
                <% if (message != null) { %>
                    <p style="color: blue;"><%= message %></p>
                <% } %>
            </div>
            <div class="form-group">
                <label for="last_name">Product Name</label> 
                <input type="text" placeholder="Enter Product Name" name="name" class="form-control" id="last_name" required>
            </div>
            <div class="form-group">
                <label for="producttype">Product Type</label> 
                <select name="type" id="producttype" class="form-control" required>
                    <option value="">-- Select Product Type --</option>
                    <option value="Pesticides">Pesticides</option>
                    <option value="Fertilizers">Fertilizers</option>
                    <option value="Market Rates">Market Rates</option>
                    <option value="Organic Pesticides">Organic Pesticides</option>
                    <option value="Travelling Goods">Travelling Goods</option>
                    <option value="Customer">Customer</option>
                    <option value="other">Some Other Appliances</option>
                </select>
            </div>
            <div class="form-group">
                <label for="description">Product Description</label>
                <textarea name="info" class="form-control" id="description" required placeholder="Enter product description..."></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price</label> 
                <input type="number" placeholder="Enter Price" name="price" class="form-control" id="price" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label> 
                <input type="number" placeholder="Enter Quantity" name="quantity" class="form-control" id="quantity" required>
            </div>
            <div class="form-group">
                <label for="image">Product Image</label> 
                <input type="file" name="image" class="form-control" id="image" required>
            </div>
            <div class="row">
                <div class="col-md-6 text-center">
                    <button type="reset" class="btn btn-danger">Reset</button>
                </div>
                <div class="col-md-6 text-center">
                    <button type="submit" class="btn btn-success">Add Product</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.html" %>
</body>
</html>
