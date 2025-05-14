package com.sd133;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class WeatherServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String input = request.getParameter("userInput");
        String encodedInput = URLEncoder.encode(input, StandardCharsets.UTF_8);

        request.setAttribute("encodedInput", encodedInput);

        RequestDispatcher rd = request.getRequestDispatcher("GetWeatherDataServlet");
        rd.forward(request, response);
    }
}
