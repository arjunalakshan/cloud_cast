import 'package:cloud_cast/providers/theme_switch_provider.dart';
import 'package:cloud_cast/screens/home_screen.dart';
import 'package:cloud_cast/services/theme_status_store_service.dart';
import 'package:cloud_cast/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeSwitchProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CloudCast Weather App",
      theme: Provider.of<ThemeSwitchProvider>(context).getThemeMode,
      home: HomeScreen(),
    );
  }
}
