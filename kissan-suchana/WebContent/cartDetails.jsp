<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*,com.ecomweb.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Rubik:wght@400;700&family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <!-- Custom Styling -->
    <style>
    body {
        font-family: 'Quicksand', sans-serif;
        margin: 0;
        background: linear-gradient(135deg, #e0f7fa, #fce4ec);
        background-size: 200% 200%;
        animation: bgAnimation 10s ease infinite;
    }

    @keyframes bgAnimation {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    .text-center {
        font-size: 26px;
        font-weight: bold;
        color: #4a148c;
        margin: 20px 0;
    }

    table.table {
        background-color: #ffffff;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        animation: fadeIn 1.2s ease-in-out;
    }

    @keyframes fadeIn {
        0% { opacity: 0; transform: translateY(30px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    .table thead {
        background: linear-gradient(to right, #6a1b9a, #8e24aa);
        color: white;
        font-size: 15px;
        font-weight: bold;
        text-transform: uppercase;
    }

    .table tbody tr {
        transition: all 0.3s ease-in-out;
    }

    .table tbody tr:hover {
        background-color: #f3e5f5;
        transform: scale(1.01);
    }

    .table td, .table th {
        vertical-align: middle !important;
        text-align: center;
        padding: 14px;
        font-size: 14px;
    }

    input[type="number"] {
        padding: 6px 10px;
        border: 1px solid #b39ddb;
        border-radius: 10px;
        width: 60px;
        text-align: center;
        transition: border-color 0.3s ease;
    }

    input[type="number"]:focus {
        outline: none;
        border-color: #7e57c2;
        box-shadow: 0 0 5px rgba(126, 87, 194, 0.5);
    }

    form .btn-primary {
        border-radius: 10px;
        padding: 6px 14px;
        font-weight: 600;
        background-color: #7c4dff;
        border: none;
    }

    form .btn-primary:hover {
        background-color: #651fff;
    }

    .fa {
        font-size: 18px;
        padding: 8px;
        border-radius: 50%;
        background-color: #ede7f6;
        color: #5e35b1;
        transition: all 0.3s ease;
    }

    a:hover .fa {
        background-color: #d1c4e9;
        color: #4a148c;
        transform: scale(1.15);
    }

    .price {
        font-size: 16px;
        color: #00796b;
        font-weight: bold;
    }

    .productname {
        font-family: 'Poppins', sans-serif;
        font-size: 15px;
        font-weight: 600;
        color: #1a237e;
    }

    tr:last-child td {
        font-size: 16px;
        font-weight: bold;
        background-color: #f0f4c3;
        color: #33691e;
    }

    button {
        border-radius: 30px !important;
        font-weight: bold;
        padding: 8px 20px;
        border: none;
    }

    button:hover {
        opacity: 0.9;
        transform: scale(1.05);
        transition: 0.2s;
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
String addS = request.getParameter("add");
if (addS != null) {
    int add = Integer.parseInt(addS);
    String uid = request.getParameter("uid");
    String pid = request.getParameter("pid");
    int avail = Integer.parseInt(request.getParameter("avail"));
    int cartQty = Integer.parseInt(request.getParameter("qty"));
    CartServiceImpl cart = new CartServiceImpl();

    if (add == 1) {
        cartQty += 1;
        if (cartQty <= avail) {
            cart.addProductToCart(uid, pid, 1);
        } else {
            response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
        }
    } else if (add == 0) {
        cart.removeProductFromCart(uid, pid);
    }
}
%>

<jsp:include page="header.jsp" />

<div class="text-center">Cart Items</div>

<div class="container">
    <table class="table table-hover">
        <thead>
            <tr>
                <th>Picture</th>
                <th>Products</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Add</th>
                <th>Remove</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody>
            <%
            CartServiceImpl cart = new CartServiceImpl();
            List<CartBean> cartItems = cart.getAllCartItems(userName);
            double totAmount = 0;
            for (CartBean item : cartItems) {
                String prodId = item.getProdId();
                int prodQuantity = item.getQuantity();
                ProductBean product = new ProductServiceImpl().getProductDetails(prodId);
                double currAmount = product.getProdPrice() * prodQuantity;
                totAmount += currAmount;

                if (prodQuantity > 0) {
            %>
            <tr>
                <td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
                <td class="productname"><%=product.getProdName()%></td>
                <td class="price"><%=product.getProdPrice()%></td>
                <td>
                    <form method="post" action="./UpdateToCart">
                        <input type="number" name="pqty" value="<%=prodQuantity%>" min="0">
                        <input type="hidden" name="pid" value="<%=product.getProdId()%>">
                        <input type="submit" name="Update" value="Update" class="btn btn-primary">
                    </form>
                </td>
                <td><a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>"><i class="fa fa-plus"></i></a></td>
                <td><a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>"><i class="fa fa-minus"></i></a></td>
                <td><%=currAmount%></td>
            </tr>
            <% } } %>

            <tr style="background-color: grey; color: white;">
                <td colspan="6" style="text-align: center;">Total Amount to Pay (in Rupees)</td>
                <td><%=totAmount%></td>
            </tr>
            <% if (totAmount != 0) { %>
            <tr style="background-color: grey; color: white;">
                <td colspan="4" style="text-align: center;"></td>
                <td>
                    <form method="post">
                        <button formaction="userHome.jsp" style="background-color: black; color: white;">Cancel</button>
                    </form>
                </td>
                <td colspan="2" align="center">
                    <form method="post">
                        <button style="background-color: blue; color: white;" formaction="payment.jsp?amount=<%=totAmount%>">Pay Now</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@ include file="footer.html"%>
</body>
</html>
