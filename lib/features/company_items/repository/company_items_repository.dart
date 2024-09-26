import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exception/app_exception_codes.dart';
import '../../../core/exception/app_internal_error.dart';
import '../model/company_asset_model.dart';
import '../model/company_location_model.dart';
import '../service/company_items_service.dart';

part 'company_items_repository.g.dart';

@singleton
class CompanyItemsRepository = _CompanyItemsRepository with _$CompanyItemsRepository;

abstract class _CompanyItemsRepository with Store {
  final CompanyItemsService _companyItemsService;

  _CompanyItemsRepository(this._companyItemsService);

  @action
  Future<List<CompanyLocationModel>> getCompanyLocations(String companyId) async {
    try {
      final resp = await _companyItemsService.getCompanyLocations(companyId);
      return resp;
    } on DioException catch (error, stack) {
      throw AppInternalError(code: kLoadCompanyLocationsErrorKey, error: error, stack: stack);
    }
  }

  @action
  Future<List<CompanyAssetModel>> getCompanyAssets(String companyId) async {
    try {
      final resp = await _companyItemsService.getCompanyAssets(companyId);
      return resp;
    } on DioException catch (error, stack) {
      throw AppInternalError(code: kLoadCompanyAssetsErrorKey, error: error, stack: stack);
    }
  }
}
