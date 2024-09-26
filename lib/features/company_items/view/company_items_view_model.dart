import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import '../../../core/constants/app_generic_constants.dart';
import '../../base_view_model.dart';
import '../model/base_company_item_model.dart';
import '../model/company_tree_item_filter_model.dart';
import '../model/company_tree_item_node_model.dart';
import '../repository/company_items_repository.dart';

part 'company_items_view_model.g.dart';

@injectable
class CompanyItemsViewModel = _CompanyItemsViewModel with _$CompanyItemsViewModel;

abstract class _CompanyItemsViewModel extends BaseViewModel with Store {
  final CompanyItemsRepository _companyItemsRepository;

  _CompanyItemsViewModel(this._companyItemsRepository);

  String? companyId;

  final companyItems = <BaseCompanyItemModel>[].asObservable();
  final companyItemsTree = <CompanyTreeItemNodeModel>[].asObservable();

  @observable
  var filter = kEmptyCompanyTreeItemFilter;

  @override
  @action
  Future<void> init() async {
    try {
      loading = true;
      final locationsResp = await _companyItemsRepository.getCompanyLocations(companyId!);
      final assetsResp = await _companyItemsRepository.getCompanyAssets(companyId!);

      companyItems.clear();
      companyItems.addAll(locationsResp);
      companyItems.addAll(assetsResp);

      final itemsTree = isRunningTests ? getItemsTree(companyItems) : await compute(getItemsTree, companyItems);
      companyItemsTree.clear();
      companyItemsTree.addAll(itemsTree);
    } finally {
      loading = false;
    }
  }
}
