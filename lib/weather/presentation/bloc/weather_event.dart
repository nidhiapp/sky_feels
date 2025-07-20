import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_event.freezed.dart';

@freezed
class WeatherEvent with _$WeatherEvent {
  const factory WeatherEvent.fetchWeather(String cityName) = FetchWeather;
  const factory WeatherEvent.refreshWeather(String cityName) = RefreshWeather;
  const factory WeatherEvent.selectForecastDay(int index) = SelectForecastDay;


}