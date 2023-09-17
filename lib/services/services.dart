import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/weatherData/weather_data.dart';

Future fetchWeatherInfo(city) async {
  try {
    String apiKey = "YOUR_API_KEY";
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      double temperature = data["main"]["temp"];
      String main = data["weather"][0]["main"];
      double windSpeed = data["wind"]["speed"];
      int humidity = data["main"]["humidity"];
      int visibility = data["visibility"];
      String name = data["name"];

      return WeatherData(
        name: name,
        temperature: temperature,
        main: main,
        windSpeed: windSpeed,
        humidity: humidity,
        visibility: visibility,
      );
    }
  } catch (e) {
    print("error" + e.toString());
  }
}
