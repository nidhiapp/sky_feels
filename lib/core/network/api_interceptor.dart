import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['appid'] = '8d42940bab34aeb38dd6d8226f44a4b5';
    options.queryParameters['units'] = 'metric'; // default unit
    super.onRequest(options, handler);
  }

}
