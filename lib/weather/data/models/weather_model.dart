import 'package:sky_feels/weather/domain/entities/weather_entity.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';
class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {
        'temp': temperature,
      },
      'weather': [
        {'main': condition},
      ],
    };
  }
}
