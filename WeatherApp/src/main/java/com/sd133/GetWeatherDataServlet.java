package com.sd133;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Scanner;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class GetWeatherDataServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String encodedInput = (String) request.getAttribute("encodedInput");

        String apiKey = "10386f98e39b9441cad5b3ae5d9cfd54";
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + encodedInput + "&appid=" + apiKey + "&units=metric";

        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        try (InputStreamReader reader = new InputStreamReader(connection.getInputStream());
             Scanner sc = new Scanner(reader)) {

            StringBuffer responseData = new StringBuffer();
            while (sc.hasNext()) {
                responseData.append(sc.nextLine());
            }

            Gson gson = new Gson();
            JsonObject jsonObj = gson.fromJson(responseData.toString(), JsonObject.class);

            // Check for the "cod" field in response to see if it's 404 (city not found)
            if (jsonObj.has("cod") && jsonObj.get("cod").getAsString().equals("404")) {
                request.setAttribute("error", "City not found. Please try another city.");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
                return;
            }

            long dateTimeStamp = jsonObj.get("dt").getAsLong() * 1000;
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
            String formattedDate = sdf.format(new java.util.Date(dateTimeStamp));

            int temp = jsonObj.getAsJsonObject("main").get("temp").getAsInt();
            int humidity = jsonObj.getAsJsonObject("main").get("humidity").getAsInt();
            double windSpeed = jsonObj.getAsJsonObject("wind").get("speed").getAsDouble();
            String weatherCondition = jsonObj.getAsJsonArray("weather").get(0).getAsJsonObject().get("main").getAsString();
            String city = jsonObj.get("name").getAsString();


            String weatherIconUrl = "https://openweathermap.org/img/wn/" + jsonObj.getAsJsonArray("weather").get(0).getAsJsonObject().get("icon").getAsString() + "@2x.png";

            // Set attributes to forward to JSP
            request.setAttribute("date", formattedDate);
            request.setAttribute("city", city);
            request.setAttribute("temp", temp);
            request.setAttribute("humidity", humidity);
            request.setAttribute("windSpeed", windSpeed);
            request.setAttribute("weatherCondition", weatherCondition);
            request.setAttribute("weatherIconUrl", weatherIconUrl);

            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while fetching weather data. Please try again later.");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
    }
}
