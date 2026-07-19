package com.tap.Utility;

import java.util.Properties;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailUtil {

    public static void sendPasswordResetEmail(String toEmail, String resetLink) {

        String smtpUser = MailConfig.getSmtpUser();
        String smtpPass = MailConfig.getSmtpPassword();

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", MailConfig.getSmtpHost());
        props.put("mail.smtp.port", MailConfig.getSmtpPort());

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpUser, "FoodRush"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Reset your FoodRush password");

            String body =
                "<p>We received a request to reset your FoodRush password.</p>" +
                "<p><a href=\"" + resetLink + "\">Click here to reset your password</a></p>" +
                "<p>This link expires in 30 minutes. If you didn't request this, you can ignore this email.</p>";

            message.setContent(body, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Password reset email sent to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            // catches java.io.UnsupportedEncodingException from InternetAddress constructor
            e.printStackTrace();
        }
    }
    
    
    public static void sendWelcomeEmail(String toEmail, String userName) {

        String smtpUser = MailConfig.getSmtpUser();
        String smtpPass = MailConfig.getSmtpPassword();

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", MailConfig.getSmtpHost());
        props.put("mail.smtp.port", MailConfig.getSmtpPort());

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpUser, "FoodRush"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to FoodRush!");

            String body =
                "<p>Hi " + userName + ",</p>" +
                "<p>Thank you for registering with <b>FoodRush</b>! We're excited to have you on board.</p>" +
                "<p>You can now log in and start ordering your favorite food.</p>" +
                "<p>Happy eating!<br/>The FoodRush Team</p>";

            message.setContent(body, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Welcome email sent to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
}