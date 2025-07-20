import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:sky_feels/weather/data/data_sources/weather_local_data_source.dart';
import 'package:sky_feels/weather/data/data_sources/weather_remote_data_source.dart';

import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'weather/data/repositories/weather_repository_impl.dart';
import 'weather/domain/repositories/weather_repository.dart';
import 'weather/presentation/bloc/weather_bloc.dart';
import 'weather/domain/usecases/weather_usecase.dart' as usecases;
import 'weather/domain/repositories/weather_repository.dart' as repositories;
final sl = GetIt.instance;

Future<void> init() async {
  // Features - Weather
  sl.registerFactory(() => WeatherBloc(sl()));

 
  sl.registerLazySingleton(() => usecases.WeatherUseCase(sl<repositories.WeatherRepository>()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(dio: sl()),
  );
  
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
    );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Dio>(() => ApiClient().client);

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
}
