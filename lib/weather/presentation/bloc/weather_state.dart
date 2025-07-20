import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';
part 'weather_state.freezed.dart';


@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded(WeatherEntity weather) = WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherError;
}
