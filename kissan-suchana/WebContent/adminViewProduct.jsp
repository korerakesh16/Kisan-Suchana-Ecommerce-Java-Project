<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*,com.ecomweb.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Products</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">
	
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">

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

        /* Updated Product Name Style */
.productname {
    font-family: 'Poppins', sans-serif;
    font-size: 16px;
    font-weight: 600;
    color: #000000; /* changed to black */
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

        .btn-danger, .btn-primary {
            border-radius: 20px;
            padding: 6px 16px;
            font-size: 14px;
            transition: all 0.2s ease-in-out;
        }

        .btn-danger:hover {
            background-color: #c0392b;
            transform: scale(1.05);
        }

        .btn-primary:hover {
            background-color: #2980b9;
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

        .product-row {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<%
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");
    String userType = (String) session.getAttribute("usertype");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    } else if (userName == null || password == null) {
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
        message = "No items found for the search " ;
        products = prodDao.getAllProducts();
    }
%>

<jsp:include page="header.jsp" />

<div class="text-center"><%=message%></div>

<!-- Product Cards -->
<div class="container">
    <div class="row text-center product-row">
        <%
            int count = 0;
            for (ProductBean product : products) {
        %>
        <div class="col-md-3 col-sm-6">
            <div class="thumbnail">
                <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"
                    style="height: 140px; max-width: 160px;">
                <p class="productname"><%=product.getProdName()%> (<%=product.getProdId()%>)</p>
                <p class="productinfo"><%=product.getProdInfo()%></p>
                <p class="price">Rs <%=product.getProdPrice()%></p>
                <form method="post">
                    <button type="submit"
                        formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>"
                        class="btn btn-danger">Remove</button>
                    &nbsp;
                    <button type="submit"
                        formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>"
                        class="btn btn-primary">Update</button>
                </form>
            </div>
        </div>
        <%
                count++;
                if (count % 4 == 0) {
        %>
    </div>
    <div class="row text-center product-row">
        <%
                }
            }
        %>
    </div>
</div>

<%@ include file="footer.html" %>

</body>
</html>
