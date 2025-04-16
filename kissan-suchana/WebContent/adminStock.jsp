<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*, com.ecomweb.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Stocks</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Quicksand:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">

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
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin: 20px 0;
        }

        .table thead {
            background-color: #2c6c4b;
            color: white;
            font-size: 18px;
        }

        .table tbody {
            background-color: white;
            font-size: 16px;
        }

        .table-hover tbody tr:hover {
            background-color: #f0fff0;
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

        .table img {
            border-radius: 8px;
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

<div class="text-center">Stock Products</div>

<div class="container-fluid">
    <div class="table-responsive">
        <table class="table table-hover table-sm">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>ProductId</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Price</th>
                    <th>Sold Qty</th>
                    <th>Stock Qty</th>
                    <th colspan="2" style="text-align: center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ProductServiceImpl productDao = new ProductServiceImpl();
                    List<ProductBean> products = productDao.getAllProducts();
                    for (ProductBean product : products) {
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
                    <td><a href="./updateProduct.jsp?prodid=<%=product.getProdId()%>"><%=product.getProdId()%></a></td>
                    <%
                        String name = product.getProdName();
                        name = name.length() > 25 ? name.substring(0, 25) + ".." : name;
                    %>
                    <td><%=name%></td>
                    <td><%=product.getProdType().toUpperCase()%></td>
                    <td>Rs <%=product.getProdPrice()%></td>
                    <td><%=new OrderServiceImpl().countSoldItem(product.getProdId())%></td>
                    <td><%=product.getProdQuantity()%></td>
                    <td>
                        <form method="post">
                            <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn btn-primary">Update</button>
                        </form>
                    </td>
                    <td>
                        <form method="post">
                            <button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn btn-danger">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                    if (products.isEmpty()) {
                %>
                <tr style="background-color: grey; color: white;">
                    <td colspan="9" style="text-align: center;">No Items Available</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="footer.html"%>
</body>
</html>
