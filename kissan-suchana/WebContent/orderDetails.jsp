<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*,com.ecomweb.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: linear-gradient(-45deg, #d4fc79, #96e6a1, #84fab0, #8fd3f4);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .text-center {
            font-size: 30px;
            font-weight: 700;
            color: #1b5e20;
            margin: 40px 0 25px;
        }

        .container {
            padding-bottom: 50px;
        }

        .table-responsive {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .table thead {
            background-color: #2e7d32;
            color: white;
            font-size: 16px;
        }

        .table tbody tr {
            transition: all 0.2s ease-in-out;
        }

        .table tbody tr:hover {
            background-color: #f1f8e9;
        }

        .productname {
            font-weight: 600;
            color: #263238;
        }

        .price {
            font-size: 16px;
            font-weight: bold;
            color: #388e3c;
        }

        .text-success {
            font-weight: bold;
        }

        img {
            border-radius: 8px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }

        header, footer {
            width: 100%;
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

    OrderService dao = new OrderServiceImpl();
    List<OrderDetails> orders = dao.getAllOrderDetails(userName);
%>

<jsp:include page="header.jsp" />

<div class="text-center">Order Details</div>

<div class="container">
    <div class="table-responsive">
        <table class="table table-hover table-sm">
            <thead>
                <tr>
                    <th>Picture</th>
                    <th>Product Name</th>
                    <th>Order ID</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (OrderDetails order : orders) {
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=order.getProductId()%>" style="width: 50px; height: 50px;"></td>
                    <td class="productname"><%=order.getProdName()%></td>
                    <td><%=order.getOrderId()%></td>
                    <td><%=order.getQty()%></td>
                    <td class="price">&#8377;<%=order.getAmount()%></td>
                    <td><%=order.getTime()%></td>
                    <td class="text-success"><%=order.getShipped() == 0 ? "ORDER_PLACED" : "ORDER_SHIPPED"%></td>
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
