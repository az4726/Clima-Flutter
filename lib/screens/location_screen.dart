import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  String cityName;
  String weatherHeader;
  String weatherIcon;
  int temperature;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      cityName = 'ERROR';
      weatherHeader = 'ERROR';
      weatherIcon = '';
      return;
    }

    cityName = weatherData['name'];
    weatherHeader = weatherData['weather'][0]['main'];
    var condition = weatherData['weather'][0]['id'];
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();

    weatherIcon = weather.getWeatherIcon(condition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.my_location,
                        size: 50.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: Text(
                  "It's $weatherHeader in $cityName",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
