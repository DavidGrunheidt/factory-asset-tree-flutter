import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/features/company_items/service/company_items_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompanyItemsService', () {
    final mockApiClient = MockTractianApiClient();

    Future<Response> getCompanyLocations() => mockApiClient.get('/companies/$companyId/locations');
    Future<Response> getCompanyAssets() => mockApiClient.get('/companies/$companyId/assets');

    final service = CompanyItemsServiceImpl(mockApiClient);

    tearDown(() {
      reset(mockApiClient);
    });

    test('getCompanyLocations throws DioException', () async {
      when(getCompanyLocations()).thenThrow(dioException);
      await expectLater(() => service.getCompanyLocations(companyId), throwsA(isA<DioException>()));

      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanyLocations returns empty list', () async {
      when(getCompanyLocations()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));
      final resp = await service.getCompanyLocations(companyId);

      expect(resp, []);
      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanyLocations returns list with 3 items', () async {
      when(getCompanyLocations()).thenAnswer(
        (_) async => Response(requestOptions: reqOpts, data: companyLocationsJson),
      );

      final resp = await service.getCompanyLocations(companyId);

      expect(resp, expectedCompanyLocations);
      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanyAssets throws DioException', () async {
      when(getCompanyAssets()).thenThrow(dioException);
      await expectLater(() => service.getCompanyAssets(companyId), throwsA(isA<DioException>()));

      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanyAssets returns empty list', () async {
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));
      final resp = await service.getCompanyAssets(companyId);

      expect(resp, []);
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanyAssets returns list with items', () async {
      when(getCompanyAssets()).thenAnswer(
        (_) async => Response(requestOptions: reqOpts, data: companyAssetsJson),
      );
      final resp = await service.getCompanyAssets(companyId);

      expect(resp, expectedCompanyAssets);
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
