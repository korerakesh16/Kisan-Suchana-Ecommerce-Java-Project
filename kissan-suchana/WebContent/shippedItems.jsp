<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
    import="com.ecomweb.service.impl.*, com.ecomweb.beans.*,com.ecomweb.service.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>shiped items</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Rubik:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

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
            font-size: 26px;
            font-weight: bold;
            color: #2c3e50;
            margin: 25px 0;
        }

        .table-responsive {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            padding: 15px;
            margin-bottom: 40px;
        }

        table.table th, table.table td {
            text-align: center;
            vertical-align: middle !important;
        }

        table.table-hover tbody tr:hover {
            background-color: #f1f1f1;
            transition: background-color 0.3s ease;
        }

        .text-success {
            font-weight: bold;
            color: #27ae60 !important;
        }

        tr.no-items {
            background-color: grey;
            color: white;
            font-weight: bold;
        }

        .table thead {
            background-color: #115884;
            color: white;
            font-size: 18px;
        }

        a {
            color: #2980b9;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <%
        /* Checking the user credentials */
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

    <div class="text-center">Shipped Orders</div>

    <div class="container-fluid">
        <div class="table-responsive">
            <table class="table table-hover table-sm">
                <thead>
                    <tr>
                        <th>TransactionId</th>
                        <th>ProductId</th>
                        <th>Username</th>
                        <th>Address</th>
                        <th>Quantity</th>
                        <th>Amount</th>
                        <th>Status</th>
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
                            if (shipped != 0) {
                                count++;
                    %>
                    <tr>
                        <td><%=transId%></td>
                        <td><a href="./updateProduct.jsp?prodid=<%=prodId%>"><%=prodId%></a></td>
                        <td><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td>Rs. <%=order.getAmount()%></td>
                        <td class="text-success">SHIPPED</td>
                    </tr>
                    <%
                            }
                        }
                        if (count == 0) {
                    %>
                    <tr class="no-items">
                        <td colspan="7">No Items Available</td>
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
