package com.tap.Utility;

public class ChatbotConfig {
    public static String getApiKey() {
        String key = System.getenv("GEMINI_API_KEY");
        if (key == null || key.isEmpty()) {
            throw new RuntimeException("GEMINI_API_KEY environment variable not set!");
        }
        return key;
    }
}