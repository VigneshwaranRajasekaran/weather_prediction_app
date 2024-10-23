class WeatherData {
  final String cityName;
  final double temperature;
  final String weather;
  final int humidity;
  final double minTemp;  // Add minTemp field

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.weather,
    required this.humidity,
    required this.minTemp,  // Initialize minTemp
  });

  // Factory constructor to create WeatherData from JSON
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      weather: json['weather'][0]['main'] ?? 'Unknown',
      humidity: json['main']['humidity'] ?? 0,
      minTemp: (json['main']['temp_min'] ?? 0).toDouble(),  // Add temp_min
    );
  }
}
