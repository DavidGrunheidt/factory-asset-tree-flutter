import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import '../../base_view_model.dart';

part 'company_asset_view_model.g.dart';

@injectable
class CompanyAssetViewModel = _CompanyAssetViewModel with _$CompanyAssetViewModel;

abstract class _CompanyAssetViewModel extends BaseViewModel with Store {}
