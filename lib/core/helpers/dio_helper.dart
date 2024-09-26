import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio createDio(BaseOptions opts, List<Interceptor> interceptors) {
  final dio = Dio(opts);
  if (kDebugMode) {
    dio.interceptors.addAll([
      CurlLoggerDioInterceptor(printOnSuccess: true),
      // PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true),
    ]);
  }

  dio.interceptors.addAll(interceptors);
  dio.options.headers['accept'] = 'application/json';
  dio.options.headers['Content-Type'] = 'application/json';
  return dio;
}
