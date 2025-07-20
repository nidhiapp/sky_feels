import 'package:dio/dio.dart';
import 'package:sky_feels/core/network/api_constants.dart';
import 'api_interceptor.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        )) {
    _dio.interceptors.add(ApiInterceptor());
  }

  Dio get client => _dio;
}
