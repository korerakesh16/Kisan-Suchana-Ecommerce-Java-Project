<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Remove Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<!-- jQuery and Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- Custom Styling -->
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(to right, #e0f7fa, #e6ffe6);
        margin: 0;
        padding: 0;
    }

    .form-container {
        background-color: #fff;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        transition: 0.3s;
        margin-top: 60px;
    }

    .form-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
    }

    .form-container h3 {
        font-weight: 600;
        color: #d35400;
        margin-bottom: 20px;
    }

    label {
        font-weight: 500;
        color: #2c3e50;
    }

    .form-control {
        border-radius: 10px;
        padding: 10px;
        font-size: 15px;
    }

    .form-control:focus {
        border-color: #28a745;
        box-shadow: 0 0 8px rgba(40, 167, 69, 0.4);
    }

    .btn {
        border-radius: 25px;
        padding: 10px 20px;
        font-size: 15px;
        font-weight: 500;
        text-transform: uppercase;
    }

    .btn-info {
        background-color: #3498db;
        border: none;
    }

    .btn-info:hover {
        background-color: #2980b9;
    }

    .btn-danger {
        background-color: #e74c3c;
        border: none;
    }

    .btn-danger:hover {
        background-color: #c0392b;
    }

    .message-box p {
        font-weight: bold;
        color: #0077b6;
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

	<%
	String message = request.getParameter("message");
	%>

	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4 form-container">
				<div class="text-center">
					<h3>Product Deletion </h3>
					<% if (message != null) { %>
					<div class="message-box">
						<p><%= message %></p>
					</div>
					<% } %>
				</div>

				<form action="./RemoveProductSrv" method="post">
					<div class="form-group">
						<label for="prodid">Product ID</label>
						<input type="text" name="prodid" class="form-control" placeholder="Enter Product ID" id="prodid" required>
					</div>
					<div class="row">
						<div class="col-md-6 text-center">
							<a href="adminViewProduct.jsp" class="btn btn-info btn-block">Cancel</a>
						</div>
						<div class="col-md-6 text-center">
							<button type="submit" class="btn btn-danger btn-block">Remove Product</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>
