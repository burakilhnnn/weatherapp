import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String apiKey = 'a00ff50c5297ab61a859886196d63a6b';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric&lang=tr'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Veri alınamadı');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası');
    }
  }
}
