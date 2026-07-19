package com.tap.Servlets;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

import com.tap.Utility.ChatbotConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chatbotServlet")
public class ChatbotServlet extends HttpServlet {

	private static final String GEMINI_URL =
		    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String userMessage = req.getParameter("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            resp.getWriter().write("{\"reply\":\"Please type a message.\"}");
            return;
        }

        try {
            String reply = callGemini(userMessage);
            // escape quotes/newlines so we return valid JSON
            String safeReply = reply.replace("\\", "\\\\")
                                     .replace("\"", "\\\"")
                                     .replace("\n", "\\n");
            resp.getWriter().write("{\"reply\":\"" + safeReply + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"reply\":\"Sorry, the chatbot is unavailable right now.\"}");
        }
    }

    private String callGemini(String userMessage) throws Exception {
        String apiKey = ChatbotConfig.getApiKey();

        // Give the model context about what it's helping with
        String systemContext = "You are a helpful assistant for a food delivery website called FoodRush. "
            + "Answer questions about food, orders, menu items, and general help using the site. "
            + "Keep answers short and friendly.";

        String escapedMsg = userMessage.replace("\\", "\\\\").replace("\"", "\\\"");
        String escapedContext = systemContext.replace("\\", "\\\\").replace("\"", "\\\"");

        String requestBody = "{"
            + "\"contents\":[{\"parts\":[{\"text\":\"" + escapedContext + "\\n\\nUser: " + escapedMsg + "\"}]}]"
            + "}";

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(GEMINI_URL + "?key=" + apiKey))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
            .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

//        return extractText(response.body());
        System.out.println("GEMINI STATUS: " + response.statusCode());
        System.out.println("GEMINI RAW RESPONSE: " + response.body());
        return extractText(response.body());
    }

    // Very small manual JSON text extractor (no extra library needed)
    private String extractText(String json) {
        String marker = "\"text\": \"";
        int idx = json.indexOf(marker);
        if (idx == -1) {
            marker = "\"text\":\"";
            idx = json.indexOf(marker);
        }
        if (idx == -1) return "Hmm, I couldn't understand the response. Try again?";

        int start = idx + marker.length();
        StringBuilder sb = new StringBuilder();
        for (int i = start; i < json.length(); i++) {
            char c = json.charAt(i);
            if (c == '\\' && i + 1 < json.length()) {
                char next = json.charAt(i + 1);
                if (next == 'n') { sb.append('\n'); i++; }
                else if (next == '"') { sb.append('"'); i++; }
                else if (next == '\\') { sb.append('\\'); i++; }
                else sb.append(c);
            } else if (c == '"') {
                break;
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}