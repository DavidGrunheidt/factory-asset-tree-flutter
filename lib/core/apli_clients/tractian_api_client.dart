import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../flavors.dart';
import '../constants/app_generic_constants.dart';
import '../helpers/dio_helper.dart';
import 'api_client.dart';

@Named(kTractianApiClient)
@Injectable(as: ApiClient)
class AlgoliaApiClient extends ApiClient {
  final _baseUrl = switch (appBuildFlavor) {
    AppBuildFlavorEnum.STG => 'https://fake-api.tractian.com',
    AppBuildFlavorEnum.PROD => 'https://fake-api.tractian.com',
  };

  final _connectTimeout = switch (appBuildFlavor) {
    AppBuildFlavorEnum.STG => const Duration(seconds: 10),
    AppBuildFlavorEnum.PROD => const Duration(seconds: 5),
  };

  final _receiveTimeout = switch (appBuildFlavor) {
    AppBuildFlavorEnum.STG => const Duration(seconds: 10),
    AppBuildFlavorEnum.PROD => const Duration(seconds: 5),
  };

  late final _baseOptions = BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: _connectTimeout,
    receiveTimeout: _receiveTimeout,
  );

  late final Dio _dio = createDio(_baseOptions, []);

  @override
  Dio get dio => _dio;
}
