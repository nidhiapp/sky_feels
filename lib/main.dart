import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_feels/core/bloc/app_bloc.dart';
import 'package:sky_feels/weather/presentation/bloc/weather_bloc.dart';
import 'package:sky_feels/weather/presentation/pages/landing_screen.dart';
import 'injection_container.dart' as ic;
import 'weather/domain/usecases/weather_usecase.dart' as usecases;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init(); // initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    
      providers: [
        BlocProvider<WeatherBloc>(
          create: (_) => WeatherBloc(ic.sl<usecases.WeatherUseCase>()),
        ),
         BlocProvider<AppBloc>(
          create: (_) => AppBloc(),
        ),
        // Add other BLoCs here as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sky Feels',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LandingScreen(),
      ),
    );
  }
}
