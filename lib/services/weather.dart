import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'e3fc98cb9c0a73dd8a7d12f53d076fca';

class WeatherModel {
  Future<dynamic> getCityLocationWeather(String cityName) async {
    Networker networker = Networker(
        'https://api.openweathermap.org/data/2.5/find?q=$cityName&units=metric&appid=$apiKey');

    var weatherData = await networker.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Networker networker = Networker(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.Latitude}&lon=${location.Longitude}&units=metric&appid=$apiKey');

    var weatherData = await networker.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
