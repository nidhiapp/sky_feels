class ForecastEntity {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final String? iconCode;
  final double? humidity;
  final double? windSpeed;
  final double? rainVolume;
  final int? pressure;
  final int? visibility;
  final int? cloudiness;
  final int? sunrise; // Unix timestamp
  final int? sunset; // Unix timestamp

  ForecastEntity({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    this.iconCode,
    this.humidity,
    this.windSpeed,
    this.rainVolume,
    this.pressure,
    this.visibility,
    this.cloudiness,
    this.sunrise,
    this.sunset,
  });
}

class WeatherEntity {
  final String cityName;
  final double temperature;
  final String condition;
  final double? windSpeed;
  final int? humidity;
  final int? pressure;
  final int? visibility;
  final int? cloudiness;
  final int? sunrise; // Unix timestamp
  final int? sunset; // Unix timestamp
  final List<ForecastEntity>? forecast;

  WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.condition,
    this.windSpeed,
    this.humidity,
    this.pressure,
    this.visibility,
    this.cloudiness,
    this.sunrise,
    this.sunset,
    this.forecast,
  });
}
