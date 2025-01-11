import 'dart:convert';
import 'dart:developer';
import 'package:cloud_cast/services/geo_loaction_service.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_cast/models/weather_data_model.dart';

class WeatherService {
  //* Base URL for Weather API
  static const baseURL = "https://api.openweathermap.org/data/2.5/weather";

  //* Set API Key Required
  final String apiKey;

  WeatherService({required this.apiKey});

  //* Get weather data by city
  Future<WeatherDataModel> getWeatherDataByCity(String city) async {
    try {
      final urlWithQueries = "$baseURL?q=$city&appid=$apiKey&units=metric";
      final response = await http.get(Uri.parse(urlWithQueries));
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        return WeatherDataModel.fromJson(responseJson);
      } else {
        log(response.statusCode.toString());
        throw Exception(
            "Failed to load weather data, StatusCode: ${response.statusCode}");
      }
    } catch (error) {
      log(error.toString());
      throw Exception("Failed to load weather data, $error");
    }
  }

  //* Get weather data by current location (GeoLocation)
  Future<WeatherDataModel> getWeatherDataByGeoLocation() async {
    try {
      GeoLoactionService geoLoactionService = GeoLoactionService();
      final city = await geoLoactionService.getCityByGeoLocation();

      final urlWithQueries = "$baseURL?q=$city&appid=$apiKey&units=metric";
      final response = await http.get(Uri.parse(urlWithQueries));
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        return WeatherDataModel.fromJson(responseJson);
      } else {
        log(response.statusCode.toString());
        throw Exception(
            "Failed to load weather data, StatusCode: ${response.statusCode}");
      }
    } catch (error) {
      log(error.toString());
      throw Exception("Failed to load weather data, $error");
    }
  }
}
