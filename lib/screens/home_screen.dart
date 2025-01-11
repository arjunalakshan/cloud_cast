import 'dart:developer';
import 'package:cloud_cast/models/weather_data_model.dart';
import 'package:cloud_cast/screens/search_weather_screen.dart';
import 'package:cloud_cast/services/weather_service.dart';
import 'package:cloud_cast/widgets/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["OPENWEATHER_API_KEY"]!);

  WeatherDataModel? _weatherDataModel;

  //* Get weather data
  void getWeatherData() async {
    try {
      final weatherByGeoLocation =
          await _weatherService.getWeatherDataByGeoLocation();
      setState(() {
        _weatherDataModel = weatherByGeoLocation;
      });
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CloudCast",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.dark_mode_rounded,
              size: 32,
            ),
          ),
        ],
      ),
      body: _weatherDataModel != null
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      WeatherData(weatherDataModel: _weatherDataModel!),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchWeatherScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.amber[100]),
                        ),
                        child: Text(
                          "Search weather",
                          style: TextStyle(
                            color: Colors.amber[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
