<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*, com.ecomweb.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payments</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

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
        background: linear-gradient(-45deg, #e0f7fa, #e8f5e9, #fff3e0, #e1f5fe);
        background-size: 400% 400%;
        animation: gradientBG 12s ease infinite;
    }

    @keyframes gradientBG {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    .form-container {
        border: none;
        border-radius: 15px;
        background-color: #ffffff;
        padding: 30px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .form-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }

    .form-container h2 {
        color: #2e7d32;
        font-weight: 700;
        margin-top: 10px;
    }

    .form-control {
        border-radius: 8px;
        box-shadow: none;
        transition: border-color 0.3s;
        color: #000; /* <-- added this line */
    }

    .form-control:focus {
        border-color: #4caf50;
        box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
    }

    .btn-success {
        background-color: #4caf50;
        border: none;
        border-radius: 8px;
        padding: 10px 20px;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-success:hover {
        background-color: #388e3c;
        transform: scale(1.03);
    }

    .payment-img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 50%;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        margin-bottom: 15px;
    }

    label {
        font-weight: 600;
    }
    .form-control {
    color: #000 !important; /* Make input text black */
    background-color: #fff;
}
    

    @media (max-width: 768px) {
        .form-container {
            padding: 20px;
        }
    }
</style>
   
</head>
<body>

<%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    String sAmount = request.getParameter("amount");
    double amount = 0;
    if (sAmount != null) {
        amount = Double.parseDouble(sAmount);
    }
%>

<jsp:include page="header.jsp" />

<div class="container">
    <div class="row" style="margin-top: 30px; margin-bottom: 30px;">
        <form action="./OrderServlet" method="post" class="col-md-6 col-md-offset-3 form-container">
            <div class="text-center">
                <img alt="Payment Proceed"  />
                <h2>Credit Card Payment</h2>
            </div>

            <div class="form-group">
                <label for="cardholder">Name of Card Holder</label>
                <input type="text" name="cardholder" class="form-control" placeholder="Enter Card Holder Name" required>
            </div>

            <div class="form-group">
                <label for="cardnumber">Enter Credit Card Number</label>
                <input type="number" name="cardnumber" class="form-control" placeholder="4242-4242-4242-4242" required>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="expmonth">Expiry Month</label>
                    <input type="number" name="expmonth" class="form-control" placeholder="MM" min="01" max="12" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="expyear">Expiry Year</label>
                    <input type="number" name="expyear" class="form-control" placeholder="YYYY" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="cvv">Enter CVV</label>
                    <input type="number" name="cvv" class="form-control" placeholder="123" required>
                    <input type="hidden" name="amount" value="<%=amount%>">
                </div>
                <div class="col-md-6 form-group">
                    <label>&nbsp;</label>
                    <button type="submit" class="form-control btn btn-success">
                        Pay : Rs <%=amount%>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.html"%>

</body>
</html>
