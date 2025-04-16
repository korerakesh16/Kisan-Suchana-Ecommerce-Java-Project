<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #d4fc79, #96e6a1);
        }
        textarea {
    color: black; /* Makes the typed text in the address box black */
}

/* Optional: if you use a placeholder in the address box */
textarea::placeholder {
    color: black;
}
        

        .container-login {
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 100%;
            padding: 50px 20px;
        }
input[type="text"],
input[type="email"],
input[type="number"],
input[type="password"],
input[type="address"],
textarea {
    color: black; /* Sets text color inside the inputs to black */
}
textarea#address {
    color: black !important;
    background-color: #f5f5f5 !important;
}

        .form-box {
            width: 100%;
            max-width: 700px;
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        }

        .form-box h2 {
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

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="password"],
        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
            background-color: #f5f5f5;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        .message {
            font-size: 14px;
            color: #2e7d32;
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

        .btn-row {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        @media screen and (max-width: 768px) {
            .container-login {
                padding: 20px;
            }

            .form-box {
                width: 100%;
                padding: 25px;
            }

            .btn-row {
                flex-direction: column;
            }
        }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

<%@ include file="header.jsp" %>

<%
    String message = request.getParameter("message");
%>

<div class="container-login">
    <form action="./RegisterSrv" method="post" class="form-box">
        <h2>Registration Form</h2>

        <%
            if (message != null) {
        %>
        <div class="message"><%= message %></div>
        <%
            }
        %>

        <div class="row">
            <div class="col-md-6">
                <label for="first_name">Name</label>
                <input type="text" name="username" class="form-control" id="first_name" required>
            </div>
            <div class="col-md-6">
                <label for="last_name">Email</label>
                <input type="email" name="email" class="form-control" id="last_name" required>
            </div>
        </div>

        <label for="address">Address</label>
        <textarea name="address" class="form-control" id="address" required></textarea>

        <div class="row">
            <div class="col-md-6">
                <label for="mobile">Mobile</label>
                <input type="number" name="mobile" class="form-control" id="mobile" required>
            </div>
            <div class="col-md-6">
                <label for="pincode">Pin Code</label>
                <input type="number" name="pincode" class="form-control" id="pincode" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label for="password">Password</label>
                <input type="password" name="password" class="form-control" id="password" required>
            </div>
            <div class="col-md-6">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
            </div>
        </div>

        <div class="btn-row">
            <button type="reset" style="background: #ff6b6b;">Reset</button>
            <button type="submit">Register</button>
        </div>
    </form>
</div>

<%@ include file="footer.html" %>
</body>
</html>
