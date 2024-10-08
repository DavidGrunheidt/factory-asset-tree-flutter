import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class ApiClient {
  @visibleForTesting
  Dio get dio;

  Future<Response<T>> get<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, bool noCache = false}) {
    final noCacheHeader = Options(headers: {'Cache-Control': 'no-cache'});
    return dio.get<T>(path, data: data, queryParameters: queryParameters, options: noCache ? noCacheHeader : null);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return dio.patch(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return dio.put(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> fetch(RequestOptions requestOptions) {
    return dio.fetch(requestOptions);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.delete(path, queryParameters: queryParameters);
  }
}
