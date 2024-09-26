import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/features/companies/service/companies_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompaniesService', () {
    final mockApiClient = MockTractianApiClient();

    Future<Response> getCompanies() => mockApiClient.get('/companies');

    final service = CompaniesServiceImpl(mockApiClient);

    tearDown(() {
      reset(mockApiClient);
    });

    test('getCompanies throws DioException', () async {
      when(getCompanies()).thenThrow(dioException);
      await expectLater(service.getCompanies, throwsA(isA<DioException>()));

      verify(getCompanies());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanies returns empty list', () async {
      when(getCompanies()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));
      final resp = await service.getCompanies();

      expect(resp, []);
      verify(getCompanies());
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getCompanies returns list with items', () async {
      when(getCompanies()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companiesJson));
      final resp = await service.getCompanies();

      expect(resp, expectedCompanies);
      verify(getCompanies());
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
