// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '/models/weather_model.dart';  // Import your WeatherData model

// class WeatherService {
//   final String apiKey = 'f76969b2358dd421b3826dcc509ebf5d';  // Replace with your OpenWeather API key
//   final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

//   // Function to fetch weather data by city name
//   Future<WeatherData?> fetchWeather(String cityName) async {
//     try {
//       // Build the API request URL
//       final url = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');

//       // Make the HTTP GET request
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         // Parse the JSON data
//         final json = jsonDecode(response.body);
//         // Convert JSON data into WeatherData model
//         return WeatherData.fromJson(json);
//       } else {
//         // Handle non-200 responses (e.g., city not found, API limit reached)
//         print('Failed to fetch weather: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       // Handle network or parsing errors
//       print('Error occurred: $e');
//       return null;
//     }
//   }
// }//*
