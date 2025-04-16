<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - KISSAN SUCHANA</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #d4fc79, #96e6a1);
        }

        .container-login {
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 100%;
            padding: 50px 20px;
        }

        .right-box {
            width: 35%;
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        }

        .right-box h2 {
            text-align: center;
            color: #2e7d32;
            margin-bottom: 30px;
            font-size: 26px;
            font-weight: 600;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
        }

        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
            background-color: #f5f5f5;
            font-size: 14px;
        }

        .message {
            font-size: 14px;
            color: #d32f2f;
            margin-bottom: 15px;
            text-align: center;
        }

        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #00c9ff, #92fe9d);
            border: none;
            border-radius: 30px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s ease;
        }

        button:hover {
            background: linear-gradient(to right, #92fe9d, #00c9ff);
            transform: scale(1.03);
        }

        @media screen and (max-width: 768px) {
            .container-login {
                flex-direction: column;
                padding: 20px;
            }
            .right-box {
                width: 100%;
                border-radius: 10px;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
    String message = request.getParameter("message");
%>

<div class="container-login">
    <!-- Right Login Box -->
    <div class="right-box">
        <h2>Log in Here</h2>
        <% if (message != null) { %>
            <p class="message"><%= message %></p>
        <% } %>

        <form action="./LoginSrv" method="post">
            <label for="username">Username</label>
            <input type="email" id="username" name="username" placeholder="Enter Username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter Password" required>

            <label for="usertype">Login As</label>
            <select name="usertype" id="usertype" required>
                <option value="customer" selected>CUSTOMER</option>
                <option value="admin">ADMIN</option>
            </select>

            <button type="submit">Login</button>
        </form>
    </div>
</div>

<%@ include file="footer.html" %>

</body>
</html>
