import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_feels/weather/data/models/weather_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class WeatherLocalDataSource {
  /// Gets the cached [WeatherModel] which was last fetched
  Future<WeatherModel> getLastWeather();

  /// Caches the [WeatherModel] to local storage
  Future<void> cacheWeather(WeatherModel weatherToCache);
}

const CACHED_WEATHER = 'CACHED_WEATHER';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(WeatherModel weatherToCache) {
    final jsonString = json.encode(weatherToCache.toJson());
    return sharedPreferences.setString(CACHED_WEATHER, jsonString);
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Future.value(WeatherModel.fromJson(jsonMap));
    } else {
      throw CacheException(); // defined in core/error/exceptions.dart
    }
  }
}
