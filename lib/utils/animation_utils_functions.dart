class AnimationUtilsFunctions {
  //* Set weather animation based on the weather condition
  String getWeatherAnimation({required String weatherCondition}) {
    switch (weatherCondition.toLowerCase()) {
      case "clear":
        return "assets/lottie/clear-animation.json";

      case "clouds":
        return "assets/lottie/clouds-animation.json";

      case "rain":
      case "drizzle":
        return "assets/lottie/rainy-animation.json";

      case "thunderstorm":
        return "assets/lottie/thunder-animation.json";

      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
      case "ash":
      case "squall":
      case "tornado":
        return "assets/lottie/misty-animation.json";

      case "snow":
        return "assets/lottie/snow-animation.json";

      default:
        return "assets/lottie/clear-animation.json";
    }
  }
}
