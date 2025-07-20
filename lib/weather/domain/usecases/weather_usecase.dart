import 'package:dartz/dartz.dart';
import 'package:sky_feels/core/error/failure.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';
import 'package:sky_feels/weather/domain/repositories/weather_repository.dart';

class WeatherUseCase{
  final WeatherRepository repository;

WeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return repository.getWeather(cityName);
  }
}
