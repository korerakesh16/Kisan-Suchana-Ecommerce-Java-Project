package com.ecomweb.utility;

import jakarta.mail.MessagingException;

public class TestMail {
	public static void main(String[] args) {
		try {
			String recipient = "kisansuchana@gmail.com";
			String subject = "Mail Configuration Successful - KISSAN SUCHANA";
			String htmlTextMessage = "" + "<html>"
					+ "<head><title>KISSAN SUCHANA - Mail Test</title>"
					+ "<style>.greenText{color:green;} p{font-size:14px; font-family:Arial, sans-serif;}</style></head>"
					+ "<body>"
					+ "<h2 style='color:green;'>Welcome to KISSAN SUCHANA</h2>"
					+ "<p>Dear User,<br><br>"
					+ "Thank you for joining <strong>KISSAN SUCHANA</strong> - your trusted companion for agricultural support.<br><br>"
					+ "We are here to empower farmers with the right information at the right time. From crop advice and fertilizer guidance to weather updates and real-time market prices — we’ve got everything covered.<br><br>"
					+ "🎁 <strong>Special Offer:</strong> As a warm welcome, get <strong>FREE expert consultation</strong> for your first query. Just log in and connect with our Agri Experts!<br><br>"
					+ "<span class='greenText'>Visit the dashboard to explore videos, articles, and personalized alerts tailored for your crops.</span><br><br>"
					+ "Stay informed, stay ahead!<br><br>"
					+ "Warm Regards,<br>"
					+ "<strong>KISSAN SUCHANA Team</strong><br>"
					+ "</p>"
					+ "</body></html>";

			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
			System.out.println("Mail Sent Successfully!");

		} catch (MessagingException e) {
			System.out.println("Mail Sending Failed With Error: " + e.getMessage());
			e.printStackTrace();
		}
	}
}
