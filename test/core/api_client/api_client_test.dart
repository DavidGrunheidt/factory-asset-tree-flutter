import 'dart:io';

import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/core/apli_clients/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/mocks/mocks_generator.mocks.dart';

void main() {
  group('ApiClient', () {
    final mockDio = MockDio();

    const baseUrl = 'https://baseurl.com';

    tearDown(() {
      reset(mockDio);
    });

    test('get performs a HTTP GET request', () async {
      const path = '$baseUrl/v1/path';
      Future<Response> getReq() => mockDio.get(path);
      when(getReq()).thenAnswer((_) async {
        return Response(requestOptions: RequestOptions(path: path), statusCode: HttpStatus.ok);
      });

      final resp = await RandApiClient(dio: mockDio).get(path);

      expect(resp.statusCode, HttpStatus.ok);
      verify(getReq());
      verifyNoMoreInteractions(mockDio);
    });

    test('post performs a HTTP POST request', () async {
      const path = '$baseUrl/v1/path';
      Future<Response> postReq() => mockDio.post(path);
      when(postReq()).thenAnswer((_) async {
        return Response(requestOptions: RequestOptions(path: path), statusCode: HttpStatus.badRequest);
      });

      final resp = await RandApiClient(dio: mockDio).post(path);

      expect(resp.statusCode, HttpStatus.badRequest);
      verify(postReq());
      verifyNoMoreInteractions(mockDio);
    });

    test('put performs a HTTP PUT request', () async {
      const path = '$baseUrl/v1/path';
      Future<Response> putReq() => mockDio.put(path);
      when(putReq()).thenAnswer((_) async {
        return Response(requestOptions: RequestOptions(path: path), statusCode: HttpStatus.unauthorized);
      });

      final resp = await RandApiClient(dio: mockDio).put(path);

      expect(resp.statusCode, HttpStatus.unauthorized);
      verify(putReq());
      verifyNoMoreInteractions(mockDio);
    });

    test('fetch performs fetch with any given reqOpts', () async {
      const path = '$baseUrl/v1/path';
      final reqOpts = RequestOptions(path: path, method: 'GET');

      Future<Response> fetchReq() => mockDio.fetch(reqOpts);
      when(fetchReq()).thenAnswer((_) async {
        return Response(requestOptions: reqOpts, statusCode: HttpStatus.ok);
      });

      final resp = await RandApiClient(dio: mockDio).fetch(reqOpts);

      expect(resp.statusCode, HttpStatus.ok);
      verify(fetchReq());
      verifyNoMoreInteractions(mockDio);
    });

    test('delete performs a HTTP DELETE request', () async {
      const path = '$baseUrl/v1/path';
      Future<Response> deleteReq() => mockDio.delete(path);
      when(deleteReq()).thenAnswer((_) async {
        return Response(requestOptions: RequestOptions(path: path), statusCode: HttpStatus.accepted);
      });

      final resp = await RandApiClient(dio: mockDio).delete(path);

      expect(resp.statusCode, HttpStatus.accepted);
      verify(deleteReq());
      verifyNoMoreInteractions(mockDio);
    });
  });
}

class RandApiClient extends ApiClient {
  RandApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Dio get dio => _dio;
}
