import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import '../../base_view_model.dart';

part 'companies_view_model.g.dart';

@injectable
class CompaniesViewModel = _CompaniesViewModel with _$CompaniesViewModel;

abstract class _CompaniesViewModel extends BaseViewModel with Store {}
