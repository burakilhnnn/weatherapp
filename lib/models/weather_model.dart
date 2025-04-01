class WeatherModel {
  final String city;
  final String temperature;
  final String description;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String city) {
    return WeatherModel(
      city: city,
      temperature: '${json['main']['temp'].round()}°C',
      description: json['weather'][0]['description'],
    );
  }

  factory WeatherModel.error(String city) {
    return WeatherModel(
      city: city,
      temperature: 'Hata',
      description: 'Veri alınamadı',
    );
  }
}
