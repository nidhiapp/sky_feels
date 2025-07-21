import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:sky_feels/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:sky_feels/weather/data/models/weather_model.dart';
import 'package:sky_feels/core/error/exceptions.dart';

// Mock class for Dio
class MockDio extends Mock implements Dio {}

void main() {
  late WeatherRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = WeatherRemoteDataSourceImpl(dio: mockDio);
  });

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

  Map<String, dynamic> tWeatherModelJson() => {
        "cityName": "London",
        "temperature": 20.0,
        "condition": "Clear",
        "windSpeed": 5.0,
        "humidity": 60,
        "pressure": 1012,
        "visibility": 10000,
        "cloudiness": 0,
        "sunrise": 1620000000,
        "sunset": 1620050000,
        "forecast": null,
      };

  void setUpMockDioSuccess200(String endpoint) {
    when(mockDio.get(endpoint, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
              data: tWeatherModelJson(),
              statusCode: 200,
              requestOptions: RequestOptions(path: endpoint),
            ));
  }

  void setUpMockDioFailure(String endpoint, int statusCode) {
    when(mockDio.get(endpoint, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
              data: 'Something went wrong',
              statusCode: statusCode,
              requestOptions: RequestOptions(path: endpoint),
            ));
  }

  group('getWeatherByCity', () {
    test('should return WeatherModel when response code is 200', () async {
      setUpMockDioSuccess200('weather');

      final result = await dataSource.getWeatherByCity(tCityName);

      expect(result, isA<WeatherModel>());
      expect(result.cityName, tWeatherModel.cityName);
      verify(mockDio.get('weather', queryParameters: {'q': tCityName}));
    });

    test('should throw ServerException when response code is not 200', () async {
      setUpMockDioFailure('weather', 404);

      expect(() => dataSource.getWeatherByCity(tCityName), throwsA(isA<ServerException>()));
    });

    test('should throw DioException when Dio throws', () async {
      when(mockDio.get('weather', queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: 'weather')));

      expect(() => dataSource.getWeatherByCity(tCityName), throwsA(isA<DioException>()));
    });
  });

  group('getForecastByCity', () {
    test('should return WeatherModel when response code is 200', () async {
      setUpMockDioSuccess200('forecast');

      final result = await dataSource.getForecastByCity(tCityName);

      expect(result, isA<WeatherModel>());
      expect(result.cityName, tWeatherModel.cityName);
      verify(mockDio.get('forecast', queryParameters: {'q': tCityName}));
    });

    test('should throw ServerException when response code is not 200', () async {
      setUpMockDioFailure('forecast', 404);

      expect(() => dataSource.getForecastByCity(tCityName), throwsA(isA<ServerException>()));
    });

    test('should throw DioException when Dio throws', () async {
      when(mockDio.get('forecast', queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: 'forecast')));

      expect(() => dataSource.getForecastByCity(tCityName), throwsA(isA<DioException>()));
    });
  });
}
