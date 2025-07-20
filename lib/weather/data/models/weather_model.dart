import 'package:sky_feels/weather/domain/entities/weather_entity.dart';

class ForecastModel extends ForecastEntity {
  final int? pressure;
  final int? visibility;
  final int? cloudiness;
  final int? sunrise; // Unix timestamp
  final int? sunset; // Unix timestamp
  final String? iconCode;

  ForecastModel({
    required String date,
    required double minTemp,
    required double maxTemp,
    required String condition,
    this.iconCode,
    double? humidity,
    double? windSpeed,
    double? rainVolume,
    this.pressure,
    this.visibility,
    this.cloudiness,
    this.sunrise,
    this.sunset,
  }) : super(
          date: date,
          minTemp: minTemp,
          maxTemp: maxTemp,
          condition: condition,
          iconCode: iconCode,
          humidity: humidity,
          windSpeed: windSpeed,
          rainVolume: rainVolume,
          pressure: pressure,
          visibility: visibility,
          cloudiness: cloudiness,
          sunrise: sunrise,
          sunset: sunset,
        );

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    double? rainVolume;
    if (json['rain'] != null) {
      if (json['rain']['3h'] != null) {
        rainVolume = (json['rain']['3h'] as num).toDouble();
      }
    }

    return ForecastModel(
      date: json['dt_txt'] ?? '',
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      iconCode: json['weather'][0]['icon'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      rainVolume: rainVolume,
      pressure: json['main']['pressure'] as int?,
      visibility: json['visibility'] as int?,
      cloudiness: json['clouds'] != null ? json['clouds']['all'] as int? : null,
      sunrise: json['sys'] != null ? json['sys']['sunrise'] as int? : null,
      sunset: json['sys'] != null ? json['sys']['sunset'] as int? : null,
    );
  }
}

class WeatherModel extends WeatherEntity {
  final int? pressure;
  final int? visibility;
  final int? cloudiness;
  final int? sunrise; // Unix timestamp
  final int? sunset; // Unix timestamp

  WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.condition,
    super.windSpeed,
    super.humidity,
    this.pressure,
    this.visibility,
    this.cloudiness,
    this.sunrise,
    this.sunset,
    super.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<ForecastModel> forecastList = [];
    if (json['list'] != null) {
      forecastList = (json['list'] as List)
          .map((item) => ForecastModel.fromJson(item))
          .toList();
    }

    return WeatherModel(
      cityName: json['city'] != null ? json['city']['name'] : json['name'],
      temperature: json['main'] != null
          ? (json['main']['temp'] as num).toDouble()
          : 0.0,
      condition: json['weather'] != null
          ? json['weather'][0]['main']
          : '',
      windSpeed: json['wind'] != null
          ? (json['wind']['speed'] as num).toDouble()
          : null,
      humidity: json['main'] != null ? json['main']['humidity'] as int? : null,
      pressure: json['main'] != null ? json['main']['pressure'] as int? : null,
      visibility: json['visibility'] as int?,
      cloudiness: json['clouds'] != null ? json['clouds']['all'] as int? : null,
      sunrise: json['sys'] != null ? json['sys']['sunrise'] as int? : null,
      sunset: json['sys'] != null ? json['sys']['sunset'] as int? : null,
      forecast: forecastList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': {'name': cityName},
      'main': {
        'temp': temperature,
        'humidity': humidity,
        'pressure': pressure,
      },
      'weather': [
        {'main': condition}
      ],
      'wind': {'speed': windSpeed},
      'visibility': visibility,
      'clouds': {'all': cloudiness},
      'sys': {
        'sunrise': sunrise,
        'sunset': sunset,
      },
      'list': forecast?.map((f) => {
            'dt_txt': f.date,
            'main': {
              'temp_min': f.minTemp,
              'temp_max': f.maxTemp,
              'pressure': f.pressure,
              'humidity': f.humidity,
            },
            'weather': [
              {'main': f.condition}
            ],
            'wind': {'speed': f.windSpeed},
            'visibility': f.visibility,
            'clouds': {'all': f.cloudiness},
            'sys': {
              'sunrise': f.sunrise,
              'sunset': f.sunset,
            },
            'rain': f.rainVolume != null ? {'3h': f.rainVolume} : null,
          }).toList(),
    };
  }
}
