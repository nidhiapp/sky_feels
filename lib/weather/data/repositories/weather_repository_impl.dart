import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sky_feels/core/error/exceptions.dart';
import 'package:sky_feels/core/error/failure.dart';
import 'package:sky_feels/core/network/network_info.dart';
import 'package:sky_feels/weather/data/data_sources/weather_local_data_source.dart';
import 'package:sky_feels/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:sky_feels/weather/data/models/weather_model.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';
import 'package:sky_feels/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource; 
  final NetworkInfo networkInfo;                

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteWeather = await remoteDataSource.getWeatherByCity(cityName);
        final remoteForecast = await remoteDataSource.getForecastByCity(cityName);

        // Combine current weather and forecast data
        final combinedWeather = WeatherModel(
          cityName: remoteWeather.cityName,
          temperature: remoteWeather.temperature,
          condition: remoteWeather.condition,
          windSpeed: remoteWeather.windSpeed,
          humidity: remoteWeather.humidity,
          forecast: remoteForecast.forecast,
        );

        localDataSource.cacheWeather(combinedWeather);
        return Right(combinedWeather);
      } else {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Left(ServerFailure('City not found. Please check the spelling.'));
      } else {
        return const Left(ServerFailure('An error occurred while fetching weather data.'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure('No cached data found: ${e.toString()}'));
    }
  }
}

