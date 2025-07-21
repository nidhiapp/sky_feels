 import 'package:flutter/material.dart';
import 'package:sky_feels/core/app_text.dart';
import '../../domain/entities/weather_entity.dart';
import 'info_card.dart';
import 'horizontal_forecast.dart';
import 'bottom_forecast_list.dart';
import 'package:sky_feels/core/app_theme.dart';
import 'weather_icon.dart';

class WeatherCard extends StatefulWidget {
  final WeatherEntity weather;
  final int selectedForecastIndex;
  final ValueChanged<int> onForecastSelected;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.selectedForecastIndex,
    required this.onForecastSelected,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  bool _isCelsius = true;

  void _toggleUnit(bool value) {
    setState(() {
      _isCelsius = value;
    });
  }

  double _convertTemp(double temp) {
    if (_isCelsius) {
      return temp;
    } else {
      return temp * 9 / 5 + 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    final forecast = widget.weather.forecast ?? [];
    final selectedDayForecast = forecast.isNotEmpty
        ? forecast[widget.selectedForecastIndex]
        : ForecastEntity(date: '', minTemp: 0, maxTemp: 0, condition: '');

    return SingleChildScrollView(
      child: Column(
        children: [
          HorizontalForecast(
            currentDay: DateTime.now(),
            selectedIndex: widget.selectedForecastIndex,
            onDaySelected: widget.onForecastSelected,
            forecasts: widget.weather.forecast ?? [],
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
              ),
              boxShadow: [
                BoxShadow(
                  color: WeatherAppTheme.gradientBlue2.withOpacity(0.4),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
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
                        Text(widget.weather.cityName,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Row(
                          children: [
                            WeatherIcon(condition: selectedDayForecast.condition, size: 20),
                            const SizedBox(width: 8),
                            Text(selectedDayForecast.condition,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                    // Temperature and toggle
                    Column(
                      children: [
                        Text(
                          "${_convertTemp(selectedDayForecast.maxTemp).toStringAsFixed(0)}°${_isCelsius ? 'C' : 'F'}",
                          style: const TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text(AppStrings.feelsLike30,
                            style: TextStyle(color: Colors.white70)),
                        Switch(
                          value: _isCelsius,
                          onChanged: _toggleUnit,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.white54,
                        ),
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
                      label: AppStrings.humidity,
                      value: "${selectedDayForecast.humidity?.toStringAsFixed(0) ?? '--'}%",
                    ),
                    InfoCard(
                      icon: Icons.air,
                      label: AppStrings.windSpeed,
                      value: "${selectedDayForecast.windSpeed?.toStringAsFixed(1) ?? '--'} km/h",
                    ),
                    InfoCard(
                      icon: Icons.cloud,
                      label: AppStrings.rain,
                      value: "${selectedDayForecast.rainVolume?.toStringAsFixed(1) ?? '--'} mm",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          BottomForecastList(weather: widget.weather),
        ],
      ),
    );
  }
}
