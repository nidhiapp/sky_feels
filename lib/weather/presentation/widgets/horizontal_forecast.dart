import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_feels/core/app_theme.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_icon.dart';

class HorizontalForecast extends StatelessWidget {
  final DateTime currentDay;
  final int selectedIndex;
  final Function(int) onDaySelected;
  final List<ForecastEntity> forecasts;

  const HorizontalForecast({
    super.key,
    required this.currentDay,
    required this.selectedIndex,
    required this.onDaySelected,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    // Generate the next 7 days
    List<DateTime> next7Days = List.generate(
      7,
      (index) => currentDay.add(Duration(days: index)),
    );

    return SizedBox(
      height: 90,
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
                      ? WeatherAppTheme.gradientBlue2.withOpacity(0.4)
                      : WeatherAppTheme.background.withOpacity(0.4),
                  selectedIndex != index
                      ? WeatherAppTheme.gradientBlue1.withOpacity(0.4)
                      : WeatherAppTheme.background.withOpacity(0.4)
                ]),
                borderRadius: BorderRadius.circular(40),
              ),
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
                  WeatherIcon(condition: forecast.condition, size: 30),
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
