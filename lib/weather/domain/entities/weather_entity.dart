class WeatherEntity {
  final String cityName;
  final double temperature;
  final String condition;
  final double? windSpeed;
  final int? humidity;

  WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.condition,
    this.windSpeed,
    this.humidity,
  });
}
