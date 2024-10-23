import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchDetailsPage extends StatefulWidget {
  final String team1;
  final String team2;
  final String venue;
  final String date;

  MatchDetailsPage({
    required this.team1,
    required this.team2,
    required this.venue,
    required this.date,
  });

  @override
  _MatchDetailsPageState createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
  Map<String, dynamic>? weatherPrediction;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final apiKey = 'f76969b2358dd421b3826dcc509ebf5d';
    final city = widget.venue; // Assuming venue is a city name
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          weatherPrediction = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.team1} vs ${widget.team2}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Wrap the entire content with Center widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              if (isLoading)
                CircularProgressIndicator()
              else ...[
                Text(
                  'Venue: ${widget.venue}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Date: ${widget.date}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Weather Prediction:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Weather Data in Cards (Horizontal Layout)
                if (weatherPrediction != null)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildWeatherCard('Temperature',
                            '${weatherPrediction!['main']['temp']}°C'),
                        _buildWeatherCard('Rain',
                            weatherPrediction!['weather'][0]['description']),
                        _buildWeatherCard('Humidity',
                            '${weatherPrediction!['main']['humidity']}%'),
                        _buildWeatherCard('Wind Speed',
                            '${weatherPrediction!['wind']['speed']} km/h'),
                      ],
                    ),
                  )
                else
                  Text('Failed to load weather data'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: fetchWeatherData,
                  child: Text('Refresh Prediction'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

// Helper method to build a weather card
  Widget _buildWeatherCard(String title, String value) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 120, // Same width for all cards
        height: 100, // Same height for all cards to avoid overflow
        padding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 8.0), // Adjust padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
