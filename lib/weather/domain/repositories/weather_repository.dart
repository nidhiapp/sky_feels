import 'package:dartz/dartz.dart';
import 'package:sky_feels/core/error/failure.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName);
}