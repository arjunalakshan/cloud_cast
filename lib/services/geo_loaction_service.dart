import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeoLoactionService {
  static const baseUrl = "http://api.openweathermap.org/geo/1.0/reverse";
  final String apiKey = dotenv.env["OPENWEATHER_API_KEY"]!;

  Future<String> getCityByGeoLocation() async {
    //* Requesting Location access
    try {
      LocationPermission locationPermission =
          await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
      }

      //* Get current location
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      log(position.toString());

      //* Pass posion to OpenWeather reverse Geo coding API to get the location name
      final String urlWithQueries =
          "$baseUrl?lat=${position.latitude}&lon=${position.longitude}&limit=1&appid=$apiKey";

      final response = await http.get(Uri.parse(urlWithQueries));
      if (response.statusCode == 200) {
        final List<dynamic> responseBodyList = jsonDecode(response.body);
        if (responseBodyList.isNotEmpty) {
          final String city = responseBodyList[0]["name"] ?? "Unknown city";
          log(city);
          return city;
        } else {
          throw Exception('No data found for the given coordinates.');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get city by geolocation: $e');
    }
  }
}
