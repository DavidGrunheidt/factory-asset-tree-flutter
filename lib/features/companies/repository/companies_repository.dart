import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exception/app_exception_codes.dart';
import '../../../core/exception/app_internal_error.dart';
import '../model/company_model.dart';
import '../service/companies_service.dart';

part 'companies_repository.g.dart';

@singleton
class CompaniesRepository = _CompaniesRepository with _$CompaniesRepository;

abstract class _CompaniesRepository with Store {
  final CompaniesService _companiesService;

  _CompaniesRepository(this._companiesService);

  final companies = <CompanyModel>[].asObservable();

  @action
  Future<void> loadCompanies() async {
    try {
      final resp = await _companiesService.getCompanies();
      companies.clear();
      companies.addAll(resp);
    } on DioException catch (error, stack) {
      throw AppInternalError(code: kLoadCompaniesErrorKey, error: error, stack: stack);
    }
  }
}
