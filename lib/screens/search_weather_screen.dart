import 'dart:developer';

import 'package:cloud_cast/models/weather_data_model.dart';
import 'package:cloud_cast/services/weather_service.dart';
import 'package:cloud_cast/widgets/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchWeatherScreen extends StatefulWidget {
  const SearchWeatherScreen({super.key});

  @override
  State<SearchWeatherScreen> createState() => _SearchWeatherScreenState();
}

class _SearchWeatherScreenState extends State<SearchWeatherScreen> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["OPENWEATHER_API_KEY"]!);

  WeatherDataModel? _weatherDataModel;

  String? _errorText;
  TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  //* Search and get weather data
  void _getWeatherBySeach() async {
    final searchQuery = _editingController.text.trim();
    try {
      if (searchQuery.isEmpty) {
        setState(() {
          _errorText = "Please enter city name to search";
        });
      } else {
        final getWeatherBySearchCity =
            await _weatherService.getWeatherDataByCity(searchQuery);
        setState(() {
          _weatherDataModel = getWeatherBySearchCity;
          _errorText = null;
        });
      }
    } catch (error) {
      log(error.toString());
      setState(() {
        _errorText = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _editingController,
                onSubmitted: (value) => _getWeatherBySeach(),
                decoration: InputDecoration(
                  label: Text("Search by city"),
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _getWeatherBySeach,
                    icon: Icon(
                      Icons.search_rounded,
                      size: 24,
                    ),
                  ),
                  suffixIconColor: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 24),
              _errorText != null
                  ? Text(
                      _errorText!,
                      style: TextStyle(
                        color: Colors.amber[600],
                        fontSize: 16,
                      ),
                    )
                  : _weatherDataModel != null
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: WeatherData(
                                weatherDataModel: _weatherDataModel!),
                          ),
                        )
                      : Text(
                          "No weather data yet, Please search to get weather data",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
