import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double Latitude;
  double Longitude;
  Position position;

  Future<void> getCurrentLocation() async {
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      Latitude = position.latitude;
      Longitude = position.longitude;
      print('Latitude, Longitude: ' +
          Latitude.toString() +
          ', ' +
          Longitude.toString());

      print(position);
    } catch (e) {
      print(e);
    }
  }

  getPosition() {
    try {} catch (e) {
      print(e);
    }
  }
}
