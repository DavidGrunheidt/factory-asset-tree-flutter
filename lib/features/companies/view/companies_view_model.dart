import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import '../../base_view_model.dart';
import '../model/company_model.dart';
import '../repository/companies_repository.dart';

part 'companies_view_model.g.dart';

@injectable
class CompaniesViewModel = _CompaniesViewModel with _$CompaniesViewModel;

abstract class _CompaniesViewModel extends BaseViewModel with Store {
  final CompaniesRepository _companiesRepository;

  _CompaniesViewModel(this._companiesRepository);

  @computed
  List<CompanyModel> get companies => _companiesRepository.companies;

  @override
  @action
  Future<void> init() async {
    try {
      loading = true;
      await _companiesRepository.loadCompanies();
    } finally {
      loading = false;
    }
  }
}
