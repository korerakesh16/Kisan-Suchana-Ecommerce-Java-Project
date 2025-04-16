<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*,com.ecomweb.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <!-- Custom Styling -->
    <style>
    body {
        font-family: 'Roboto', sans-serif;
        background: #d0e6f2;
        padding-top: 20px;
    }

    .text-center {
        font-size: 22px;
        font-weight: bold;
        color: #1e3d47;
        margin-bottom: 15px;
    }

    .form-container {
        margin-top: 30px;
        padding: 25px 30px;
        background-color: #2ecc71;
        border-radius: 12px;
        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        max-width: 600px; /* Decreased width */
        margin: 30px auto;
    }

    .form-control {
        border-radius: 6px;
        box-shadow: none;
        font-size: 14px;
        height: 38px;
        padding: 8px;
        background-color: #ffffff !important;
        color: #000000 !important;
    }

    textarea.form-control {
        height: auto;
        color: #000000 !important;
        background-color: #ffffff !important;
    }

    .form-group label {
        font-weight: 600;
        color: #ffffff;
        font-size: 14px;
    }

    h2 {
        color: #ffffff;
        font-weight: 700;
        font-family: 'Quicksand', sans-serif;
        margin-bottom: 15px;
        font-size: 22px;
    }

    .btn-danger, .btn-success {
        border-radius: 20px;
        padding: 10px 16px;
        font-size: 14px;
    }

    .btn-danger {
        background-color: #e74c3c;
    }

    .btn-danger:hover {
        background-color: #c0392b;
    }

    .btn-success {
        background-color: #27ae60;
    }

    .btn-success:hover {
        background-color: #2ecc71;
    }

    .alert-info {
        font-size: 14px;
        padding: 10px;
        background-color: #d9edf7;
        border: 1px solid #bce8f1;
        color: #31708f;
    }

    .thumbnail {
        border-radius: 12px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        background-color: #ffffff;
    }

    .thumbnail:hover {
        transform: translateY(-6px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    }
</style>
    
</head>
<body>

<%
    String utype = (String) session.getAttribute("usertype");
    String uname = (String) session.getAttribute("username");
    String pwd = (String) session.getAttribute("password");
    String prodid = request.getParameter("prodid");
    ProductBean product = new ProductServiceImpl().getProductDetails(prodid);

    if (prodid == null || product == null) {
        response.sendRedirect("updateProductById.jsp?message=Please Enter a valid product Id");
        return;
    } else if (utype == null || !utype.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        return;
    } else if (uname == null || pwd == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }
%>

<jsp:include page="header.jsp" />

<%
    String message = request.getParameter("message");
%>

<div class="container">
    <div class="form-container">
        <form action="./UpdateProductSrv" method="post">
            <div class="text-center">
                <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product Image" style="max-height: 150px; margin-bottom: 20px;">
                <h2>Update Product Details</h2>
                <% if (message != null) { %>
                    <div class="alert alert-info" style="margin-top: 10px;"><%=message%></div>
                <% } %>
            </div>

            <input type="hidden" name="pid" value="<%=product.getProdId()%>">

            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" class="form-control" value="<%=product.getProdName()%>" required>
            </div>

            <div class="form-group">
                <label>Product Type</label>
                <select name="type" class="form-control" required>
                    <option value="Pestiside" <%= "Pestiside".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Pestiside</option>
                    <option value="Fertilizers" <%= "Fertilizers".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Fertilizers</option>
                    <option value="Market Rates" <%= "Market Rates".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Market Rates</option>
                    <option value="Organic Products" <%= "Organic Products".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Organic Products</option>
                    <option value="Travelling Goods" <%= "Travelling Goods".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Travelling Goods</option>
                    <option value="Customer" <%= "Customer".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Customer</option>
                    <option value="other" <%= "other".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Some Other Appliances</option>
                </select>
            </div>

            <div class="form-group">
                <label>Product Description</label>
                <textarea name="info" class="form-control" rows="4" required><%=product.getProdInfo()%></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Unit Price</label>
                    <input type="number" name="price" value="<%=product.getProdPrice()%>" class="form-control" required>
                </div>
                <div class="col-md-6 form-group">
                    <label>Stock Quantity</label>
                    <input type="number" name="quantity" value="<%=product.getProdQuantity()%>" class="form-control" required>
                </div>
            </div>

            <div class="row text-center" style="margin-top: 30px;">
                <div class="col-md-4 col-md-offset-2">
                    <button formaction="adminViewProduct.jsp" class="btn btn-danger btn-block">Cancel</button>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-success btn-block">Update Product</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.html" %>
</body>
</html>
