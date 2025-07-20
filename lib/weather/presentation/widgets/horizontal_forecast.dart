import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_feels/core/app_theme.dart';
import '../../domain/entities/weather_entity.dart';

class HorizontalForecast extends StatelessWidget {
  final DateTime currentDay;
  final int selectedIndex;
  final Function(int) onDaySelected;
  final List<ForecastEntity> forecasts;

  const HorizontalForecast({
    Key? key,
    required this.currentDay,
    required this.selectedIndex,
    required this.onDaySelected,
    required this.forecasts,
  }) : super(key: key);

  Widget _getWeatherIcon(String? condition) {
    if (condition == null) {
      return const Icon(Icons.wb_cloudy, size: 40, color: Colors.grey);
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return const Icon(Icons.wb_sunny, color: Colors.orange, size: 40);
      case 'clouds':
        return const Icon(Icons.cloud, color: Colors.blueGrey, size: 40);
      case 'rain':
      case 'drizzle':
        return const Icon(Icons.beach_access, color: Colors.blue, size: 40);
      case 'snow':
        return const Icon(Icons.ac_unit, color: Colors.lightBlue, size: 40);
      case 'thunderstorm':
        return const Icon(Icons.flash_on, color: Colors.yellow, size: 40);
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return const Icon(Icons.filter_drama, color: Colors.grey, size: 40);
      default:
        return const Icon(Icons.wb_cloudy, size: 40, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Generate the next 7 days
    List<DateTime> next7Days = List.generate(
      7,
      (index) => currentDay.add(Duration(days: index)),
    );

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final day = next7Days[index];
          final forecast = forecasts[index]; // Ensure forecasts has 7 items

          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    selectedIndex != index
                        ? WeatherAppTheme.gradientBlue2
                        : WeatherAppTheme.background,
                    selectedIndex != index
                        ? WeatherAppTheme.gradientBlue1
                        : WeatherAppTheme.background
                  ]),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(day), // e.g. Mon, Tue
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          selectedIndex != index ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _getWeatherIcon(forecast.condition),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
