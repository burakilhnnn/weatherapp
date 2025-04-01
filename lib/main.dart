import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather_page.dart';

const String apiKey = 'a00ff50c5297ab61a859886196d63a6b';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hava Durumu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherPage(),
    );
  }
}
