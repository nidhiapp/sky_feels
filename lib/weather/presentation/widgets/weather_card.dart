import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';
import 'info_card.dart';
import 'horizontal_forecast.dart';
import 'bottom_forecast_list.dart';
import 'package:sky_feels/core/app_theme.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;
  final int selectedForecastIndex;
  final ValueChanged<int> onForecastSelected;
  //final Animation<double> fadeAnimation;

  const WeatherCard({
    Key? key,
    required this.weather,
    required this.selectedForecastIndex,
    required this.onForecastSelected,
  //  required this.fadeAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecast = weather.forecast ?? [];
    final selectedDayForecast = forecast.isNotEmpty
        ? forecast[selectedForecastIndex]
        : ForecastEntity(date: '', minTemp: 0, maxTemp: 0, condition: '');

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          HorizontalForecast(
            currentDay: DateTime.now(),
            selectedIndex: selectedForecastIndex,
            onDaySelected: onForecastSelected,
            forecasts: weather.forecast ?? [],
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    WeatherAppTheme.gradientBlue1,
                    WeatherAppTheme.gradientBlue2
                  ],
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // City & condition
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(weather.cityName,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(selectedDayForecast.condition,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white70)),
                      ],
                    ),
                    // Temperature
                    Column(
                      children: [
                        Text(
                            "${selectedDayForecast.maxTemp.toStringAsFixed(0)}°",
                            style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Text("Feels like 32°",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Info cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoCard(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: "${selectedDayForecast.humidity?.toStringAsFixed(0) ?? '--'}%",
                    ),
                    InfoCard(
                      icon: Icons.air,
                      label: "Wind",
                      value: "${selectedDayForecast.windSpeed?.toStringAsFixed(1) ?? '--'} km/h",
                    ),
                    InfoCard(
                      icon: Icons.cloud,
                      label: "Rain",
                      value: "${selectedDayForecast.rainVolume?.toStringAsFixed(1) ?? '--'} mm",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          BottomForecastList(weather: weather),
        ],
      ),
    );
  }
}
