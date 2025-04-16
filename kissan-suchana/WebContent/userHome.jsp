<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.ecomweb.service.impl.*, com.ecomweb.service.*,com.ecomweb.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>kisan suchana</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Rubik:wght@400;700&family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

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
        background: linear-gradient(270deg, #e6ffe6, #dff9fb, #e0ffe0);
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

    .thumbnail {
        border-radius: 15px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        padding: 10px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        background-color: #ffffff;
        height: 100%;
    }

    .thumbnail:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
    }

    .productname {
        font-family: 'Poppins', sans-serif;
        font-size: 16px;
        font-weight: 600;
        color: #000000;
        margin-top: 10px;
    }

    .productinfo {
        font-size: 13px;
        color: #7f8c8d;
        min-height: 45px;
    }

    .price {
        font-size: 18px;
        font-weight: bold;
        color: #16a085;
        margin-bottom: 10px;
    }

    .btn-sm {
        padding: 4px 10px !important;
        font-size: 12px !important;
        border-radius: 20px;
    }

    .btn-danger:hover {
        background-color: #c0392b;
        transform: scale(1.05);
    }

    .btn-primary:hover {
        background-color: #2980b9;
        transform: scale(1.05);
    }

    .btn-success:hover {
        background-color: #27ae60;
        transform: scale(1.05);
    }

    .product-row {
        margin-bottom: 30px;
    }
</style>
</head>
<body>

<%
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    ProductServiceImpl prodDao = new ProductServiceImpl();
    List<ProductBean> products = new ArrayList<ProductBean>();

    String search = request.getParameter("search");
    String type = request.getParameter("type");
    String message = "All Products";

    if (search != null) {
        products = prodDao.searchAllProducts(search);
        message = "Showing Results for '" + search + "'";
    } else if (type != null) {
        products = prodDao.getAllProductsByType(type);
        message = "Showing Results for '" + type + "'";
    } else {
        products = prodDao.getAllProducts();
    }

    if (products.isEmpty()) {
        message = "No items found for the search ";
        products = prodDao.getAllProducts();
    }
%>

<jsp:include page="header.jsp" />

<div class="text-center"><%= message %></div>

<div class="container">
    <div class="row text-center">
        <%
        int count = 0;
        for (ProductBean product : products) {
            int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());

            if (count % 4 == 0 && count != 0) {
        %>
    </div>
    <div class="row text-center">
        <%
            }
        %>
        <div class="col-sm-3" style='height: 380px; margin-bottom: 20px;'>
            <div class="thumbnail">
                <img src="./ShowImage?pid=<%= product.getProdId() %>" alt="Product" style="height: 150px; max-width: 180px;">
                <p class="productname"><%= product.getProdName() %></p>
                <%
                    String description = product.getProdInfo();
                    description = description.substring(0, Math.min(description.length(), 100));
                %>
                <p class="productinfo"><%= description %>..</p>
                <p class="price">Rs <%= product.getProdPrice() %></p>
                <form method="post">
                    <%
                    if (cartQty == 0) {
                    %>
                    <button type="submit"
                        formaction="./AddtoCart?uid=<%= userName %>&pid=<%= product.getProdId() %>&pqty=1"
                        class="btn btn-success btn-sm">Add to Cart</button>
                    &nbsp;
                    <button type="submit"
                        formaction="./AddtoCart?uid=<%= userName %>&pid=<%= product.getProdId() %>&pqty=1"
                        class="btn btn-primary btn-sm">Buy Now</button>
                    <%
                    } else {
                    %>
                    <button type="submit"
                        formaction="./AddtoCart?uid=<%= userName %>&pid=<%= product.getProdId() %>&pqty=0"
                        class="btn btn-danger btn-sm">Remove</button>
                    &nbsp;
                    <button type="submit" formaction="cartDetails.jsp"
                        class="btn btn-success btn-sm">Checkout</button>
                    <%
                    }
                    %>
                </form>
            </div>
        </div>
        <%
            count++;
        }
        %>
    </div>
</div>

<%@ include file="footer.html"%>

</body>
</html>
