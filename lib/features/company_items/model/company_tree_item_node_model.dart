import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum/sensor_status_enum.dart';
import '../enum/sensor_type_enum.dart';
import 'base_company_item_model.dart';
import 'company_asset_model.dart';
import 'company_location_model.dart';
import 'company_tree_item_filter_model.dart';

part 'company_tree_item_node_model.g.dart';

@CopyWith()
class CompanyTreeItemNodeModel extends Equatable {
  final BaseCompanyItemModel item;
  final List<CompanyTreeItemNodeModel> nodes;
  final int treeLevel;

  const CompanyTreeItemNodeModel({
    required this.item,
    required this.nodes,
    required this.treeLevel,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [item, nodes];
}

extension CompanyTreeItemNodeModelExtension on CompanyTreeItemNodeModel {
  bool matchesFilter(CompanyTreeItemFilterModel filter) {
    final itemNode = item;
    final isEnergySensor = filter.energySensor && itemNode is CompanyAssetModel && itemNode.sensorType.isEnergy;
    final isAlertStatus = filter.criticalStatus && itemNode is CompanyAssetModel && itemNode.status.isAlert;
    final containsQuery = filter.query != null && itemNode.name.toLowerCase().contains(filter.query!.toLowerCase());
    return isEnergySensor || isAlertStatus || containsQuery || nodes.any((el) => el.matchesFilter(filter));
  }
}

extension ListBaseCompanyItemModelExtension on List<BaseCompanyItemModel> {
  List<BaseCompanyItemModel> get _rootItems => where((el) => el.isRoot).toList();

  List<CompanyTreeItemNodeModel> _getNodesForItem(BaseCompanyItemModel item, int treeLevel) {
    final nodes = where((el) =>
        el is CompanyLocationModel && el.parentId == item.id ||
        el is CompanyAssetModel && (el.parentId == item.id || el.locationId == item.id)).toList();

    if (nodes.isEmpty) return [];
    return nodes.map((itemNode) {
      return CompanyTreeItemNodeModel(
        item: itemNode,
        nodes: _getNodesForItem(itemNode, treeLevel + 1),
        treeLevel: treeLevel,
      );
    }).toList();
  }
}

// Needs to be top-level to be used inside compute function
List<CompanyTreeItemNodeModel> getItemsTree(List<BaseCompanyItemModel> companyItems) {
  final treeLevel = 0;
  final rootItems = companyItems._rootItems;
  final rootTreeItems = rootItems.map((itemNode) {
    final nodes = companyItems._getNodesForItem(itemNode, treeLevel + 1);
    nodes.sort((a, b) => b.nodes.length.compareTo(a.nodes.length));

    return CompanyTreeItemNodeModel(item: itemNode, nodes: nodes, treeLevel: treeLevel);
  }).toList();

  rootTreeItems.sort((a, b) => b.nodes.length.compareTo(a.nodes.length));
  return rootTreeItems;
}
