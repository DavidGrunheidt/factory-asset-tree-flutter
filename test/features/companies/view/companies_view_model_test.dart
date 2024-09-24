import 'package:factory_asset_tree_flutter/core/exception/app_exception_codes.dart';
import 'package:factory_asset_tree_flutter/core/exception/app_internal_error.dart';
import 'package:factory_asset_tree_flutter/features/companies/model/company_model.dart';
import 'package:factory_asset_tree_flutter/features/companies/view/companies_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompaniesViewModel', () {
    final mockCompaniesRepository = MockCompaniesRepository();

    Future<void> loadCompanies() => mockCompaniesRepository.loadCompanies();
    mobx.ObservableList<CompanyModel> getCompanies() => mockCompaniesRepository.companies;

    late CompaniesViewModel viewModel;

    setUp(() {
      viewModel = CompaniesViewModel(mockCompaniesRepository);
    });

    tearDown(() {
      reset(mockCompaniesRepository);
    });

    test('init throws AppInternalError and sets loading to false', () async {
      when(loadCompanies()).thenThrow(AppInternalError(code: kLoadCompaniesErrorKey));
      when(getCompanies()).thenAnswer((_) => <CompanyModel>[].asObservable());

      await expectLater(
        viewModel.init,
        throwsA(predicate((ex) => ex is AppInternalError && ex.code == kLoadCompaniesErrorKey)),
      );

      expect(viewModel.loading, false);
      expect(viewModel.companies, []);
      verify(loadCompanies());
      verify(getCompanies());
      verifyNoMoreInteractions(mockCompaniesRepository);
    });

    test('init loads companies with empty list', () async {
      when(loadCompanies()).thenAnswer((_) async {});
      when(getCompanies()).thenAnswer((_) => <CompanyModel>[].asObservable());

      await viewModel.init();

      expect(viewModel.loading, false);
      expect(viewModel.companies, []);
      verify(loadCompanies());
      verify(getCompanies());
      verifyNoMoreInteractions(mockCompaniesRepository);
    });

    test('init loads companies with empty list', () async {
      when(loadCompanies()).thenAnswer((_) async {});
      when(getCompanies()).thenAnswer((_) => expectedCompanies.asObservable());

      await viewModel.init();

      expect(viewModel.loading, false);
      expect(viewModel.companies, expectedCompanies);
      verify(loadCompanies());
      verify(getCompanies());
      verifyNoMoreInteractions(mockCompaniesRepository);
    });
  });
}
