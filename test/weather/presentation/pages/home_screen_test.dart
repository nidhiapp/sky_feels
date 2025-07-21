gimport 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_bloc.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_state.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_event.dart';
import 'package:sky_feels/weather/presentation/pages/home_screen.dart';
import 'package:sky_feels/weather/presentation/widgets/weather_card.dart';
import 'package:sky_feels/weather/domain/entities/weather_entity.dart';

class MockWeatherBloc extends Mock implements WeatherBloc {}

class FakeWeatherState extends Fake implements WeatherState {}

class FakeWeatherEvent extends Fake implements WeatherEvent {}

void main() {
  late WeatherBloc weatherBloc;

  setUpAll(() {
    registerFallbackValue(FakeWeatherState());
    registerFallbackValue(FakeWeatherEvent());
  });

  setUp(() {
    weatherBloc = MockWeatherBloc();
    when(() => weatherBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => weatherBloc.state).thenReturn(const WeatherState.loading());
  });

  tearDown(() {
    weatherBloc.close();
  });

  testWidgets('HomeScreen shows loading indicator when state is loading', (WidgetTester tester) async {
    when(() => weatherBloc.state).thenReturn(const WeatherState.loading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<WeatherBloc>.value(
          value: weatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomeScreen shows weather card when state is loaded', (WidgetTester tester) async {
    final weatherEntity = WeatherEntity(
      cityName: 'Test City',
      temperature: 25.0,
      condition: 'Clear',
      forecast: [],
      // Add other required fields with dummy data if needed
    );

    final weatherState = WeatherState.loaded(weather: weatherEntity, selectedForecastIndex: 0);

    when(() => weatherBloc.state).thenReturn(weatherState);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<WeatherBloc>.value(
          value: weatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Verify that WeatherCard widget is shown
    expect(find.byType(WeatherCard), findsOneWidget);
  });

  // Add more tests as needed
}
