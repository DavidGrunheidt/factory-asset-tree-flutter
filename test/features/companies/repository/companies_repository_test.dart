import 'package:factory_asset_tree_flutter/core/exception/app_exception_codes.dart';
import 'package:factory_asset_tree_flutter/core/exception/app_internal_error.dart';
import 'package:factory_asset_tree_flutter/features/companies/model/company_model.dart';
import 'package:factory_asset_tree_flutter/features/companies/repository/companies_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompaniesRepository', () {
    final mockCompaniesService = MockCompaniesService();

    Future<List<CompanyModel>> loadCompanies() => mockCompaniesService.getCompanies();

    late CompaniesRepository repository;

    setUp(() {
      repository = CompaniesRepository(mockCompaniesService);
    });

    tearDown(() {
      reset(mockCompaniesService);
    });

    test('loadCompanies throws AppInternalError with kGetCompaniesErrorKey', () async {
      when(loadCompanies()).thenThrow(dioException);
      await expectLater(
        repository.loadCompanies,
        throwsA(predicate((ex) => ex is AppInternalError && ex.code == kLoadCompaniesErrorKey)),
      );

      verify(loadCompanies());
      verifyNoMoreInteractions(mockCompaniesService);
    });

    test('loadCompanies throws Exception', () async {
      when(loadCompanies()).thenThrow(Exception());
      await expectLater(repository.loadCompanies, throwsException);

      verify(loadCompanies());
      verifyNoMoreInteractions(mockCompaniesService);
    });

    test('loadCompanies loads empty list', () async {
      when(loadCompanies()).thenAnswer((_) async => []);
      await repository.loadCompanies();

      expect(repository.companies, []);
      verify(loadCompanies());
      verifyNoMoreInteractions(mockCompaniesService);
    });

    test('loadCompanies loads list with items', () async {
      when(loadCompanies()).thenAnswer((_) async => expectedCompanies);
      await repository.loadCompanies();

      expect(repository.companies, expectedCompanies);
      verify(loadCompanies());
      verifyNoMoreInteractions(mockCompaniesService);
    });
  });
}
