class WeatherData {
  final double temperature;
  final String main;
  final double windSpeed;
  final int humidity;
  final int visibility;
  final String name;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.main,
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
  });
}