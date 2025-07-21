import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_feels/core/app_theme.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_icon.dart';

class BottomForecastList extends StatelessWidget {
  final WeatherEntity weather;

  const BottomForecastList({
    super.key,
    required this.weather,
  });

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
        final formattedDate = DateFormat('dd MMM  EEEE').format(date);

        return ListTile(
          leading: WeatherIcon(condition: dayForecast.condition, size: 35),
          title: Text(formattedDate),
          trailing: Text(
            "${dayForecast.minTemp.toStringAsFixed(0)}° / ${dayForecast.maxTemp.toStringAsFixed(0)}°",
            style: WeatherAppTheme.subtitle,
          ),
          subtitle: Text(dayForecast.condition),
        );
      }).toList(),
    );
  }
}
