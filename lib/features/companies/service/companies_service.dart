import 'package:injectable/injectable.dart';

import '../../../core/apli_clients/api_client.dart';
import '../../../core/constants/app_generic_constants.dart';
import '../model/company_model.dart';

// ignore: one_member_abstracts
abstract class CompaniesService {
  Future<List<CompanyModel>> getCompanies();
}

@Injectable(as: CompaniesService)
class CompaniesServiceImpl implements CompaniesService {
  final ApiClient _apiClient;

  const CompaniesServiceImpl(@Named(kTractianApiClient) this._apiClient);

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final resp = await _apiClient.get('/companies');
    final respList = resp.data is List ? resp.data as List : [];
    final companies = respList.map((el) => CompanyModel.fromJson(el as Map<String, dynamic>)).toList();
    return companies;
  }
}
