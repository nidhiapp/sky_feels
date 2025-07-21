import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_feels/core/app_theme.dart';
import '../../domain/entities/weather_entity.dart';

class BottomForecastList extends StatelessWidget {
  final WeatherEntity weather;

  const BottomForecastList({
    super.key,
    required this.weather,
  });

  Widget _getWeatherIcon(String? condition) {
    if (condition == null) {
      return const Icon(Icons.wb_cloudy, size: 40, color: Colors.grey);
    }
    switch (condition.toLowerCase()) {
      case 'clear':
        return const Icon(Icons.wb_sunny, color: Colors.orange, size: 40);
      case 'clouds':
        return const Icon(Icons.cloud, color: Color.fromARGB(255, 135, 188, 215), size: 40);
      case 'rain':
      case 'drizzle':
        return const Icon(Icons.beach_access, color: Colors.blue, size: 40);
      case 'snow':
        return const Icon(Icons.ac_unit, color: Color.fromARGB(255, 99, 106, 109), size: 40);
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
    final forecast = weather.forecast ?? [];

    final dailyForecasts = <ForecastEntity>[];
    final uniqueDays = <String>{};

    for (final f in forecast) {
      try {
        final date = DateTime.parse(f.date);
        final dayKey = DateFormat('yyyy-MM-dd').format(date);
        if (uniqueDays.add(dayKey)) {
          dailyForecasts.add(f);
        }
      } catch (e) {
        debugPrint('Could not parse date: ${f.date}');
      }
    }

    return Column(
      children: dailyForecasts.map((dayForecast) {
        final date = DateTime.parse(dayForecast.date);
        final formattedDate = DateFormat('dd MMM  EEEE').format(date); // 👈 New format

        return ListTile(
          leading: SizedBox(
            width: 40,
            height: 40,
            child: _getWeatherIcon(dayForecast.condition),
          ),
          title: Text(formattedDate),
          trailing: Text(
            "${dayForecast.minTemp.toStringAsFixed(0)}° / ${dayForecast.maxTemp.toStringAsFixed(0)}°",
            style: WeatherAppTheme.subtitle
          ),
          subtitle: Text(dayForecast.condition),
        );
      }).toList(),
    );
  }
}
