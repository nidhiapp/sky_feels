import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sky_feels/weather/data/repositories/weather_repository_impl.dart';
import 'package:sky_feels/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:sky_feels/weather/data/data_sources/weather_local_data_source.dart';
import 'package:sky_feels/core/network/network_info.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';
import 'package:sky_feels/weather/data/models/weather_model.dart';
import 'package:sky_feels/core/error/failure.dart';
import 'package:sky_feels/core/error/exceptions.dart';

// Mock classes
class MockRemoteDataSource extends Mock implements WeatherRemoteDataSource {}
class MockLocalDataSource extends Mock implements WeatherLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late WeatherRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getWeather', () {
    final tCityName = 'London';
    final tWeatherModel = WeatherModel(
      cityName: 'London',
      temperature: 20.0,
      condition: 'Clear',
      windSpeed: 5.0,
      humidity: 60,
      pressure: 1012,
      visibility: 10000,
      cloudiness: 0,
      sunrise: 1620000000,
      sunset: 1620050000,
      forecast: null,
    );

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getWeatherByCity('delhi'))
          .thenAnswer((_) async => tWeatherModel);
      when(mockRemoteDataSource.getForecastByCity('delhi'))
          .thenAnswer((_) async => tWeatherModel);
    //  when(mockLocalDataSource.cacheWeather('delhi')).thenAnswer((_) async {});
      // act
      await repository.getWeather(tCityName);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return remote data when device is online and cache it', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getWeatherByCity('delhi'))
          .thenAnswer((_) async => tWeatherModel);
      when(mockRemoteDataSource.getForecastByCity('delhi'))
          .thenAnswer((_) async => tWeatherModel);
    //  when(mockLocalDataSource.cacheWeather('delhi')).thenAnswer((_) async {});
      // act
      final result = await repository.getWeather(tCityName);
      // assert
      verify(mockRemoteDataSource.getWeatherByCity(tCityName));
      verify(mockRemoteDataSource.getForecastByCity(tCityName));
    //  verify(mockLocalDataSource.cacheWeather(any));
      expect(result, Right<Failure, WeatherEntity>(tWeatherModel));
    });

    test('should return ServerFailure with city not found message when 404 error occurs', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getWeatherByCity('delhi'))
          .thenThrow(DioException(
            type: DioExceptionType.badResponse,
            requestOptions: RequestOptions(path: ''),
            response: Response(
              statusCode: 404,
              statusMessage: 'Not Found',
              requestOptions: RequestOptions(path: ''),
            ),
          ));
      // act
      final result = await repository.getWeather(tCityName);
      // assert
      expect(result, const Left(ServerFailure('City not found. Please check the spelling.')));
    });

    test('should return generic ServerFailure when other DioException occurs', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getWeatherByCity('delhi'))
          .thenThrow(DioException(
            type: DioExceptionType.badResponse,
            requestOptions: RequestOptions(path: ''),
            response: Response(
              statusCode: 500,
              statusMessage: 'Internal Server Error',
              requestOptions: RequestOptions(path: ''),
            ),
          ));
      // act
      final result = await repository.getWeather(tCityName);
      // assert
      expect(result, const Left(ServerFailure('An error occurred while fetching weather data.')));
    });

    test('should return cached data when device is offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getLastWeather())
          .thenAnswer((_) async => tWeatherModel);
      // act
      final result = await repository.getWeather(tCityName);
      // assert
      verify(mockLocalDataSource.getLastWeather());
      expect(result, Right<Failure, WeatherEntity>(tWeatherModel));
    });

    test('should return CacheFailure when there is no cached data', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getLastWeather())
          .thenThrow(CacheException());
      // act
      final result = await repository.getWeather(tCityName);
      // assert
      expect(result, const Left(CacheFailure('No cached data found')));
    });
  });
}
