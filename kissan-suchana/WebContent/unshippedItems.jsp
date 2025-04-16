<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
    import="com.ecomweb.service.impl.*, com.ecomweb.beans.*,com.ecomweb.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">

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
            font-size: 22px;
            font-weight: bold;
            color: #2c3e50;
            margin: 30px 0 20px;
        }

        .table {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        thead {
            background-color: #700fb7;
            color: white;
        }

        .table-hover tbody tr:hover {
            background-color: #f0f9f0;
        }

        .btn-success {
            border-radius: 20px;
            padding: 6px 16px;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease-in-out;
        }

        .btn-success:hover {
            background-color: #27ae60;
            transform: scale(1.05);
        }

        td a {
            color: #2980b9;
            font-weight: 600;
        }

        td a:hover {
            text-decoration: underline;
        }

        .no-items {
            background-color: grey;
            color: white;
            font-size: 16px;
        }

        .container-fluid {
            padding-bottom: 40px;
        }
    </style>
</head>
<body>

    <%
        String userType = (String) session.getAttribute("usertype");
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userType == null || !userType.equals("admin")) {
            response.sendRedirect("loginFirst.jsp");
        }

        if (userName == null || password == null) {
            response.sendRedirect("loginFirst.jsp");
        }
    %>

    <jsp:include page="header.jsp" />

    <div class="text-center">UnShipped Orders</div>

    <div class="container-fluid">
        <div class="table-responsive">
            <table class="table table-hover table-sm">
                <thead>
                    <tr>
                        <th>TransactionId</th>
                        <th>ProductId</th>
                        <th>User Email Id</th>
                        <th>Address</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        OrderServiceImpl orderdao = new OrderServiceImpl();
                        List<OrderBean> orders = new ArrayList<OrderBean>();
                        orders = orderdao.getAllOrders();
                        int count = 0;
                        for (OrderBean order : orders) {
                            String transId = order.getTransactionId();
                            String prodId = order.getProductId();
                            int quantity = order.getQuantity();
                            int shipped = order.getShipped();
                            String userId = new TransServiceImpl().getUserId(transId);
                            String userAddr = new UserServiceImpl().getUserAddr(userId);
                            if (shipped == 0) {
                                count++;
                    %>
                    <tr>
                        <td><%= transId %></td>
                        <td><a href="./updateProduct.jsp?prodid=<%= prodId %>"><%= prodId %></a></td>
                        <td><%= userId %></td>
                        <td><%= userAddr %></td>
                        <td><%= quantity %></td>
                        <td>READY_TO_SHIP</td>
                        <td>
                            <a href="ShipmentServlet?orderid=<%= order.getTransactionId() %>&amount=<%= order.getAmount() %>&userid=<%= userId %>&prodid=<%= order.getProductId() %>" class="btn btn-success">SHIP NOW</a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                        if (count == 0) {
                    %>
                    <tr class="no-items">
                        <td colspan="7" style="text-align: center;">No Items Available</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="footer.html" %>
</body>
</html>
