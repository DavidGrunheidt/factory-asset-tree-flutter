import 'package:factory_asset_tree_flutter/core/exception/app_exception_codes.dart';
import 'package:factory_asset_tree_flutter/core/exception/app_internal_error.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_asset_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_location_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/repository/company_items_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompanyItemsRepository', () {
    final mockCompanyItemsService = MockCompanyItemsService();

    Future<List<CompanyLocationModel>> getCompanyLocations() => mockCompanyItemsService.getCompanyLocations(companyId);
    Future<List<CompanyAssetModel>> getCompanyAssets() => mockCompanyItemsService.getCompanyAssets(companyId);

    late CompanyItemsRepository repository;

    setUp(() {
      repository = CompanyItemsRepository(mockCompanyItemsService);
    });

    tearDown(() {
      reset(mockCompanyItemsService);
    });

    test('getCompanyLocations throws AppInternalError with kLoadCompanyLocationsErrorKey', () async {
      when(getCompanyLocations()).thenThrow(dioException);
      await expectLater(
        () => repository.getCompanyLocations(companyId),
        throwsA(predicate((ex) => ex is AppInternalError && ex.code == kLoadCompanyLocationsErrorKey)),
      );

      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyLocations throws Exception', () async {
      when(getCompanyLocations()).thenThrow(Exception());
      await expectLater(() => repository.getCompanyLocations(companyId), throwsException);

      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyLocations loads empty list', () async {
      when(getCompanyLocations()).thenAnswer((_) async => []);
      final resp = await repository.getCompanyLocations(companyId);

      expect(resp, []);
      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyLocations loads list with items', () async {
      when(getCompanyLocations()).thenAnswer((_) async => expectedCompanyLocations);
      final resp = await repository.getCompanyLocations(companyId);

      expect(resp, expectedCompanyLocations);
      verify(getCompanyLocations());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyAssets throws AppInternalError with kLoadCompanyAssetsErrorKey', () async {
      when(getCompanyAssets()).thenThrow(dioException);
      await expectLater(
        () => repository.getCompanyAssets(companyId),
        throwsA(predicate((ex) => ex is AppInternalError && ex.code == kLoadCompanyAssetsErrorKey)),
      );

      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyAssets throws Exception', () async {
      when(getCompanyAssets()).thenThrow(Exception());
      await expectLater(() => repository.getCompanyAssets(companyId), throwsException);

      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyAssets loads empty list', () async {
      when(getCompanyAssets()).thenAnswer((_) async => []);
      final resp = await repository.getCompanyAssets(companyId);

      expect(resp, []);
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });

    test('getCompanyAssets loads list with items', () async {
      when(getCompanyAssets()).thenAnswer((_) async => expectedCompanyAssets);
      final resp = await repository.getCompanyAssets(companyId);

      expect(resp, expectedCompanyAssets);
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyItemsService);
    });
  });
}
