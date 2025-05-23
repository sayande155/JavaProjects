<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Weather App</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>

<style>
header {
	width: 100%;
	text-align: center;
	color: #ffffff;
	font-size: 2rem;
	position: absolute;
	top: 0;
	padding: 1rem;
	background-color: rgba(0, 0, 0, 0.3);
	font-weight: bold;
}

footer {
	width: 100%;
	text-align: center;
	color: #ffffff;
	font-size: 1rem;
	position: absolute;
	bottom: 0;
	padding: 0.7rem;
	background-color: rgba(0, 0, 0, 0.3);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Ubuntu", sans-serif;
}

body {
	display: flex;
	height: 100vh;
	align-items: center;
	justify-content: center;
	background: linear-gradient(to right, #2b40ff, #07121a);
}

.mainContainer {
	width: 25rem;
	height: auto;
	border-radius: 1rem;
	background: #fff;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
}

.searchInput {
	width: 100%;
	display: flex;
	padding: 1rem 1rem;
	justify-content: center;
}

.searchInput input {
	width: 100%;
	height: 2rem;
	outline: none;
	font-size: 1rem;
	color: #525050;
	padding: 0.2rem 0.5rem;
	border-radius: 1.5rem;
	border: 1px solid #b3b3b3;
}

.searchInput input:focus {
	border: 1px solid #9c9dde;
}

.searchInput button {
	width: 2.2rem;
	height: 2rem;
	cursor: pointer;
	color: #9b9b9b;
	border-radius: 50%;
	margin-left: 0.4rem;
	transition: all 0.3s ease;
	background-color: #fff;
	border: 1px solid #b3b3b3;
}

.searchInput button:hover {
	color: #fff;
	background-color: #9c9dde;
	border: 1px solid #9c9dde;
}

.weatherIcon {
	display: flex;
	padding-top: 0.5rem;
	padding-bottom: 0.5rem;
	justify-content: center;
}

.weatherIcon img {
	max-width: 100%;
	width: 8rem;
}

.weatherDetails .temp {
	font-size: 2rem;
}

.cityDetails {
	color: #323232;
	font-size: 2.5rem;
	text-align: center;
	margin-bottom: 0.5rem;
}

.cityDetails .date {
	color: #323232;
	font-size: 1.5rem;
	text-align: center;
	margin-bottom: 0.5rem;
}

.windDetails {
	display: flex;
	margin-top: 1rem;
	margin-bottom: 1.5rem;
	justify-content: space-around;
}

.windDetails .humidityBox {
	display: flex;
	font-size: 1rem;
	color: #323232;
}

.windDetails .humidity .humidityValue {
	text-align: center;
	font-size: 2rem;
	color: #323232;
}

.windDetails .humidityBox img {
	max-height: 3rem;
	margin-right: 0.5rem;
}

.windDetails .windSpeed {
	display: flex;
	font-size: 1rem;
	color: #323232;
}

.windDetails .windSpeed img {
	max-height: 3rem;
	margin-right: 0.5rem;
}

.error-message {
	color: red;
	font-size: 1.2rem;
	text-align: center;
	margin-top: 20px;
}
</style>

<body>

	<header>
		<h1>De's Weather App</h1>
	</header>
	<br>
	<div class="mainContainer">
		<form action="WeatherServlet" method="post" class="searchInput">
			<input type="text" placeholder="Enter City Name" id="searchInput"
				name="userInput" />
			<button id="searchButton">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
		</form>

		<%-- Check if there's an error message to display --%>
		<%
		String errorMessage = (String) request.getAttribute("error");
		if (errorMessage != null) {
		%>
		<div class="error-message">
			<p><%=errorMessage%></p>
		</div>
		<%
		}
		%>

		<div class="weatherDetails">
			<div class="weatherIcon">
				<img src="weather-logo.png" alt="Clouds" id="weather-icon">
				<h2><%=request.getAttribute("temp") != null ? request.getAttribute("temp") + " °C" : ""%></h2>
				<input type="hidden" id="wc"
					value="<%=request.getAttribute("weatherCondition") != null ? request.getAttribute("weatherCondition") : ""%>" />
			</div>

			<div class="cityDetails">
				<div class="desc">
					<strong><%=request.getAttribute("city") != null ? request.getAttribute("city") : ""%></strong>
				</div>
				<div class="date"><%=request.getAttribute("date") != null ? request.getAttribute("date") : ""%></div>
			</div>

			<div class="windDetails">
				<div class="humidityBox">
					<img
						src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhgr7XehXJkOPXbZr8xL42sZEFYlS-1fQcvUMsS2HrrV8pcj3GDFaYmYmeb3vXfMrjGXpViEDVfvLcqI7pJ03pKb_9ldQm-Cj9SlGW2Op8rxArgIhlD6oSLGQQKH9IqH1urPpQ4EAMCs3KOwbzLu57FDKv01PioBJBdR6pqlaxZTJr3HwxOUlFhC9EFyw/s320/thermometer.png"
						alt="Humidity">
					<div class="humidity">
						<span>Humidity</span>
						<h2><%=request.getAttribute("humidity") != null ? request.getAttribute("humidity") + "%" : ""%></h2>
					</div>
				</div>

				<div class="windSpeed">
					<img
						src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiyaIguDPkbBMnUDQkGp3wLRj_kvd_GIQ4RHQar7a32mUGtwg3wHLIe0ejKqryX8dnJu-gqU6CBnDo47O7BlzCMCwRbB7u0Pj0CbtGwtyhd8Y8cgEMaSuZKrw5-62etXwo7UoY509umLmndsRmEqqO0FKocqTqjzHvJFC2AEEYjUax9tc1JMWxIWAQR4g/s320/wind.png">
					<div class="wind">
						<span>Wind Speed</span>
						<h2><%=request.getAttribute("windSpeed") != null ? request.getAttribute("windSpeed") + " km/h" : ""%></h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<footer>&copy Sayan De 2025</footer>

	<script src="script.js"></script>

</body>
</html>
