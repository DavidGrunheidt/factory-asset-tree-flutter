import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/core/helpers/dio_helper.dart';
import 'package:factory_asset_tree_flutter/flavors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/mocks/mocks_generator.mocks.dart';

void main() {
  group('DioHelper', () {
    appBuildFlavor = AppBuildFlavorEnum.STG;

    final mockDio = MockDio();

    const baseUrl = 'https://baseurl.com';

    tearDown(() {
      reset(mockDio);
    });

    test('createDio instantiate Dio with default options', () async {
      final baseOptions = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      );

      final dio = createDio(baseOptions, []);

      expect(dio.interceptors.length, 2);
      expect(dio.options.baseUrl, baseUrl);
      expect(dio.options.connectTimeout, baseOptions.connectTimeout);
      expect(dio.options.receiveTimeout, baseOptions.receiveTimeout);
      expect(dio.options.headers['accept'], 'application/json');
      expect(dio.options.headers['Content-Type'], 'application/json');
    });
  });
}
