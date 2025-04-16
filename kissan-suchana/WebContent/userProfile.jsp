<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.ecomweb.service.impl.*, com.ecomweb.service.*, com.ecomweb.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Details</title>
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
            background: linear-gradient(-45deg, #e6ffe6, #dff9fb, #e0ffe0, #c8facc);
            background-size: 600% 600%;
            animation: gradientBG 15s ease infinite;
            margin: 0;
            padding: 0;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            padding-top: 40px;
            padding-bottom: 60px;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            padding: 25px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
        }

        .card img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            object-fit: cover;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }

        .profile-heading {
            font-size: 26px;
            font-weight: 700;
            color: #16a085;
            text-align: center;
            margin-bottom: 15px;
        }

        .card-body p {
            font-size: 15px;
            color: #34495e;
            margin: 0;
        }

        .card-body p.text-muted {
            font-weight: 600;
            color: #2c3e50;
        }

        .breadcrumb {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 10px 15px;
            font-weight: 500;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .breadcrumb a {
            color: #2e7d32;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        hr {
            border-top: 1px dashed #bdc3c7;
            margin: 10px 0 15px;
        }

        .text-center h5 {
            font-weight: 600;
            font-size: 20px;
            color: #2c3e50;
            margin-top: 10px;
        }

        @media (max-width: 768px) {
            .profile-heading {
                font-size: 22px;
            }

            .text-center h5 {
                font-size: 18px;
            }

            .card-body p {
                font-size: 14px;
            }

            .container {
                padding: 20px 15px;
            }
        }
    </style>
</head>

<body>

<%
    // Session validation
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    UserService dao = new UserServiceImpl();
    UserBean user = dao.getUserDetails(userName, password);
    if (user == null)
        user = new UserBean("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, Bihar", 87659, "lksdjf");
%>

<jsp:include page="header.jsp" />

<div class="container">
    <div class="row">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                    <li class="breadcrumb-item active">User Profile</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row">
        <!-- Profile Image & Section Heading -->
        <div class="col-lg-4">
            <div class="card text-center mb-4">
                <div class="card-body">
                    <img src="images/kissan suchana dp.jpg" class="img-fluid" alt="Profile Picture">
                    <h5 class="my-3">Hello <%= user.getName() %> here!!</h5>
                </div>
            </div>
            <div class="card mb-4">
                <div class="card-body">
                    <h2 class="profile-heading">My Profile</h2>
                </div>
            </div>
        </div>

        <!-- User Details -->
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-3"><p>Full Name</p></div>
                        <div class="col-sm-9"><p class="text-muted"><%= user.getName() %></p></div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3"><p>Email</p></div>
                        <div class="col-sm-9"><p class="text-muted"><%= user.getEmail() %></p></div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3"><p>Phone</p></div>
                        <div class="col-sm-9"><p class="text-muted"><%= user.getMobile() %></p></div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3"><p>Address</p></div>
                        <div class="col-sm-9"><p class="text-muted"><%= user.getAddress() %></p></div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3"><p>PinCode</p></div>
                        <div class="col-sm-9"><p class="text-muted"><%= user.getPinCode() %></p></div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- /.row -->
</div> <!-- /.container -->

<%@ include file="footer.html"%>

</body>
</html>
