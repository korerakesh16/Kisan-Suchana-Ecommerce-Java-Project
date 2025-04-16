package com.ecomweb.utility;

import jakarta.mail.MessagingException;

public class MailMessage {

	public static void registrationSuccess(String emailId, String name) {
		String recipient = emailId;
		String subject = "Welcome to KISSAN SUCHANA - Your Farming Companion";
		String htmlTextMessage = "<html><body>"
				+ "<h2 style='color:green;'>Welcome to KISSAN SUCHANA</h2>"
				+ "Namaste " + name + ",<br><br>"
				+ "Thank you for joining <strong>KISSAN SUCHANA</strong> – your trusted digital companion for all agricultural needs.<br><br>"
				+ "We’re here to support you with expert advice, real-time crop information, weather updates, market prices, and the best practices in modern farming."
				+ "<br><br>As a special welcome, enjoy access to videos, audios, and articles in your local language to boost your farming knowledge and productivity!"
				+ "<br><br><b>Stay connected. Stay informed. Grow better!</b>"
				+ "<br><br>Warm regards,<br>"
				+ "<span style='color:green;font-weight:bold;'>Team KISSAN SUCHANA</span>"
				+ "</body></html>";
		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static void transactionSuccess(String recipientEmail, String name, String transId, double transAmount) {
		String recipient = recipientEmail;
		String subject = "Order Confirmed - KISSAN SUCHANA Store";
		String htmlTextMessage = "<html><body>"
				+ "<p>Namaste " + name + ",<br><br>"
				+ "Thank you for your order with <strong>KISSAN SUCHANA Store</strong>!"
				+ "<br><br>Your order has been confirmed and will be processed soon."
				+ "<br><br><strong>Order Details:</strong><br>"
				+ "<font color='red'><b>Order ID:</b></font> <font color='green'><b>" + transId + "</b></font><br>"
				+ "<font color='red'><b>Amount Paid:</b></font> <font color='green'><b>₹" + transAmount + "</b></font><br><br>"
				+ "We are committed to delivering high-quality agricultural tools and services to your doorstep."
				+ "<br><br>Thank you for trusting us.<br><br>"
				+ "<b>Team KISSAN SUCHANA</b></p></body></html>";
		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static void orderShipped(String recipientEmail, String name, String transId, double transAmount) {
		String recipient = recipientEmail;
		String subject = "Good News! Your Order is on the Way - KISSAN SUCHANA";
		String htmlTextMessage = "<html><body>"
				+ "<p>Dear " + name + ",<br><br>"
				+ "Your order from <strong>KISSAN SUCHANA</strong> has been shipped and will reach you soon!"
				+ "<br><br><strong>Shipment Details:</strong><br>"
				+ "<font color='red'><b>Order ID:</b></font> <font color='green'><b>" + transId + "</b></font><br>"
				+ "<font color='red'><b>Amount Paid:</b></font> <font color='green'><b>₹" + transAmount + "</b></font><br><br>"
				+ "We appreciate your trust in us. Happy Farming!"
				+ "<br><br><b>Team KISSAN SUCHANA</b></p></body></html>";
		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static void productAvailableNow(String recipientEmail, String name, String prodName, String prodId) {
		String recipient = recipientEmail;
		String subject = "Product Now Available - " + prodName + " | KISSAN SUCHANA";
		String htmlTextMessage = "<html><body>"
				+ "<p>Namaste " + name + ",<br><br>"
				+ "The product you were looking for is now available at <strong>KISSAN SUCHANA</strong>!"
				+ "<br><br><strong>Product Details:</strong><br>"
				+ "<font color='red'><b>Product Name:</b></font> <font color='green'><b>" + prodName + "</b></font><br>"
				+ "<font color='red'><b>Product ID:</b></font> <font color='green'><b>" + prodId + "</b></font><br><br>"
				+ "Visit our app or website now and place your order before it runs out!"
				+ "<br><br>Happy Shopping & Farming!<br><br>"
				+ "<b>Team KISSAN SUCHANA</b></p></body></html>";
		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static String sendMessage(String toEmailId, String subject, String htmlTextMessage) {
		try {
			JavaMailUtil.sendMail(toEmailId, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
			return "FAILURE";
		}
		return "SUCCESS";
	}
}
