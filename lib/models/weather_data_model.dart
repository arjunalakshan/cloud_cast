class WeatherDataModel {
  final String city;
  final double temprature;
  final String condition;
  final String description;
  final double windSpeed;
  final double pressure;
  final double humidity;

  WeatherDataModel({
    required this.city,
    required this.temprature,
    required this.condition,
    required this.description,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
  });

  //* Convert json to WeatherDataModel
  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      city: json["name"],
      temprature: json["main"]["temp"].toDouble(),
      condition: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      windSpeed: json["wind"]["speed"].toDouble(),
      pressure: json["main"]["pressure"].toDouble(),
      humidity: json["main"]["humidity"].toDouble(),
    );
  }
}
