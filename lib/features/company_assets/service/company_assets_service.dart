import 'package:injectable/injectable.dart';

import '../../../core/apli_clients/api_client.dart';
import '../../../core/constants/app_generic_constants.dart';

// ignore: one_member_abstracts
abstract class CompanyAssetsService {
  Future<void> getCompanyLocations(String companyId);
  Future<void> getCompanyAssets(String companyId);
}

@Injectable(as: CompanyAssetsService)
class CompanyAssetsServiceImpl implements CompanyAssetsService {
  final ApiClient _apiClient;

  const CompanyAssetsServiceImpl(@Named(kTractianApiClient) this._apiClient);

  @override
  Future<void> getCompanyLocations(String companyId) async {}

  @override
  Future<void> getCompanyAssets(String companyId) async {}
}
