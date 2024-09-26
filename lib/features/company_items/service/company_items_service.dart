import 'package:injectable/injectable.dart';

import '../../../core/apli_clients/api_client.dart';
import '../../../core/constants/app_generic_constants.dart';
import '../model/company_asset_model.dart';
import '../model/company_location_model.dart';

abstract class CompanyItemsService {
  Future<List<CompanyLocationModel>> getCompanyLocations(String companyId);

  Future<List<CompanyAssetModel>> getCompanyAssets(String companyId);
}

@Injectable(as: CompanyItemsService)
class CompanyItemsServiceImpl implements CompanyItemsService {
  final ApiClient _apiClient;

  const CompanyItemsServiceImpl(@Named(kTractianApiClient) this._apiClient);

  @override
  Future<List<CompanyLocationModel>> getCompanyLocations(String companyId) async {
    final resp = await _apiClient.get('/companies/$companyId/locations');
    final respList = resp.data is List ? resp.data as List : [];
    final locations = respList.map((el) => CompanyLocationModel.fromJson(el as Map<String, dynamic>)).toList();
    return locations;
  }

  @override
  Future<List<CompanyAssetModel>> getCompanyAssets(String companyId) async {
    final resp = await _apiClient.get('/companies/$companyId/assets');
    final respList = resp.data is List ? resp.data as List : [];
    final assets = respList.map((el) => CompanyAssetModel.fromJson(el as Map<String, dynamic>)).toList();
    return assets;
  }
}
