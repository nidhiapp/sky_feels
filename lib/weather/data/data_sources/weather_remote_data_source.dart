import 'package:dio/dio.dart';
import 'package:sky_feels/core/error/exceptions.dart';
import 'package:sky_feels/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByCity(String cityName);
  Future<WeatherModel> getForecastByCity(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    final response = await dio.get('weather', queryParameters: {'q': cityName});

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getForecastByCity(String cityName) async {
    final response = await dio.get('forecast', queryParameters: {'q': cityName});

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
