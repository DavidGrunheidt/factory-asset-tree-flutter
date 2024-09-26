import 'package:factory_asset_tree_flutter/core/exception/app_exception_codes.dart';
import 'package:factory_asset_tree_flutter/core/exception/app_internal_error.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_asset_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_location_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/view/company_items_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompanyItemsiewModel', () {
    final mockCompanyAssetRepository = MockCompanyItemsRepository();

    Future<List<CompanyLocationModel>> getCompanyLocations() =>
        mockCompanyAssetRepository.getCompanyLocations(companyId);
    Future<List<CompanyAssetModel>> getCompanyAssets() => mockCompanyAssetRepository.getCompanyAssets(companyId);

    late CompanyItemsViewModel viewModel;

    setUp(() {
      viewModel = CompanyItemsViewModel(mockCompanyAssetRepository);
      viewModel.companyId = companyId;
    });

    tearDown(() {
      reset(mockCompanyAssetRepository);
    });

    test('init throws AppInternalError when loading locations and sets loading to false', () async {
      when(getCompanyLocations()).thenThrow(AppInternalError(code: kLoadCompanyLocationsErrorKey));
      await expectLater(
        viewModel.init,
        throwsA(predicate((ex) => ex is AppInternalError && ex.code == kLoadCompanyLocationsErrorKey)),
      );

      expect(viewModel.loading, false);
      expect(viewModel.companyItems, []);
      verify(getCompanyLocations());
      verifyNever(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyAssetRepository);
    });

    test('init throws AppInternalError when loading assets and sets loading to false', () async {
      when(getCompanyLocations()).thenAnswer((_) async => expectedCompanyLocations);
      when(getCompanyAssets()).thenThrow(AppInternalError(code: kLoadCompanyAssetsErrorKey));

      await expectLater(
        viewModel.init,
        throwsA(predicate((ex) => ex is AppInternalError && ex.code == kLoadCompanyAssetsErrorKey)),
      );

      expect(viewModel.loading, false);
      expect(viewModel.companyItems, []);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyAssetRepository);
    });

    test('init loads locations and assets with empty list', () async {
      when(getCompanyLocations()).thenAnswer((_) async => []);
      when(getCompanyAssets()).thenAnswer((_) async => []);

      await viewModel.init();

      expect(viewModel.loading, false);
      expect(viewModel.companyItems, []);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyAssetRepository);
    });

    test('init loads locations and assets with items', () async {
      when(getCompanyLocations()).thenAnswer((_) async => expectedCompanyLocations);
      when(getCompanyAssets()).thenAnswer((_) async => expectedCompanyAssets);

      await viewModel.init();

      expect(viewModel.loading, false);
      expect(viewModel.companyItems, expectedCompanyItems);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockCompanyAssetRepository);
    });
  });
}
