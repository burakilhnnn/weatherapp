import 'package:flutter/material.dart';

class WeatherDrawer extends StatelessWidget {
  final List<String> searchedCities;
  final Function(String) onCitySelected;

  const WeatherDrawer({
    super.key,
    required this.searchedCities,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey[800]),
            child: const Text(
              'Arama Geçmişi',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          if (searchedCities.isEmpty)
            const ListTile(
              title: Text('Henüz şehir araması yapılmadı'),
              leading: Icon(Icons.history),
            )
          else
            ...searchedCities.map(
              (city) => ListTile(
                title: Text(city),
                leading: const Icon(Icons.location_city),
                onTap: () => onCitySelected(city),
              ),
            ),
        ],
      ),
    );
  }
}
