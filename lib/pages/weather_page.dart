import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import '../widgets/weather_drawer.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = false;
  final List<String> _searchedCities = [];

  Future<void> getWeather() async {
    if (_searchController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final data = await _weatherService.getWeather(_searchController.text);
      setState(() {
        _weather = WeatherModel.fromJson(data, _searchController.text);
        if (!_searchedCities.contains(_searchController.text)) {
          _searchedCities.add(_searchController.text);
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _weather = WeatherModel.error(_searchController.text);
        _isLoading = false;
      });
    }
  }

  void _searchCity(String city) {
    _searchController.text = city;
    getWeather();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Hava Durumu'),
        backgroundColor: Colors.grey[800],
        elevation: 0,
      ),
      drawer: WeatherDrawer(
        searchedCities: _searchedCities,
        onCitySelected: _searchCity,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Şehir adı girin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: getWeather,
                    ),
                  ),
                  onSubmitted: (_) => getWeather(),
                ),
                const SizedBox(height: 30),

                if (_weather != null)
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather!.city,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          if (_isLoading)
                            const CircularProgressIndicator()
                          else ...[
                            Text(
                              _weather!.temperature,
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _weather!.description,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
