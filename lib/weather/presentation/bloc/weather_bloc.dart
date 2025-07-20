import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_feels/core/error/failure.dart';
import 'package:sky_feels/weather/domain/usecases/weather_usecase.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUseCase getWeatherUseCase;

  WeatherBloc(this.getWeatherUseCase) : super(const WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<RefreshWeather>(_onRefreshWeather);
  }

  Future<void> _onFetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading());
    final result = await getWeatherUseCase(event.cityName);
    result.fold(
      (failure) => emit(WeatherError(_mapFailureToMessage(failure))),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onRefreshWeather(
      RefreshWeather event, Emitter<WeatherState> emit) async {
    // You could show pull-to-refresh indicator separately if needed
    final result = await getWeatherUseCase(event.cityName);
    result.fold(
      (failure) => emit(WeatherError(_mapFailureToMessage(failure))),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'An unexpected error has occurred.';
    }
  }
}
