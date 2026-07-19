package com.tap.Utility;

public class MailConfig {

    public static String getSmtpUser() {
        String user = System.getenv("SMTP_USER");
        if (user == null || user.isEmpty()) {
            throw new RuntimeException("SMTP_USER environment variable not set!");
        }
        return user;
    }

    public static String getSmtpPassword() {
        String pass = System.getenv("SMTP_PASS");
        if (pass == null || pass.isEmpty()) {
            throw new RuntimeException("SMTP_PASS environment variable not set!");
        }
        return pass;
    }

    // Gmail SMTP defaults — change these if you use a different provider
    public static String getSmtpHost() {
        return "smtp.gmail.com";
    }

    public static String getSmtpPort() {
        return "587";
    }
}