import 'package:cloud_cast/models/weather_data_model.dart';
import 'package:cloud_cast/utils/animation_utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherData extends StatelessWidget {
  final WeatherDataModel weatherDataModel;
  const WeatherData({
    super.key,
    required this.weatherDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset(
              AnimationUtilsFunctions().getWeatherAnimation(
                weatherCondition: weatherDataModel.condition,
              ),
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: MediaQuery.sizeOf(context).height * 0.5,
            ),
          ),
          SizedBox(height: 40),
          Text(
            weatherDataModel.city,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${weatherDataModel.temprature.toStringAsFixed(1)} °C",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Text(
                "${weatherDataModel.condition} -",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Text(
                weatherDataModel.description,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _extraWeatherDetails("Pressure",
                  "${weatherDataModel.pressure.toStringAsFixed(2)} hPa"),
              _extraWeatherDetails(
                  "Humidity", "${weatherDataModel.humidity.toString()} %"),
              _extraWeatherDetails("Wind speed",
                  "${weatherDataModel.windSpeed.toString()} meter/sec"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _extraWeatherDetails(String extraLabel, String extraValue) {
    return Column(
      children: [
        Text(
          extraLabel,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          extraValue,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
