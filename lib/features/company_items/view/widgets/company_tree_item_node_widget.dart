import 'package:flutter/material.dart';

import '../../../../core/constants/app_generic_constants.dart';
import '../../../../core/design_system/theme/app_assets.dart';
import '../../../../core/design_system/theme/custom_colors.dart';
import '../../../../core/design_system/theme/custom_radius.dart';
import '../../../../core/design_system/theme/custom_text_style.dart';
import '../../../../core/design_system/widgets/custom_png_icon.dart';
import '../../../../core/design_system/widgets/custom_spacer.dart';
import '../../../../core/design_system/widgets/custom_svg_icon.dart';
import '../../enum/sensor_status_enum.dart';
import '../../enum/sensor_type_enum.dart';
import '../../model/base_company_item_model.dart';
import '../../model/company_asset_model.dart';
import '../../model/company_tree_item_filter_model.dart';
import '../../model/company_tree_item_node_model.dart';
import 'company_tree_level_indicators_widget.dart';

class CompanyTreeItemNodeWidget extends StatefulWidget {
  final CompanyTreeItemNodeModel itemNode;
  final CompanyTreeItemFilterModel filter;
  final bool isRoot;

  const CompanyTreeItemNodeWidget({
    super.key,
    required this.itemNode,
    required this.filter,
    this.isRoot = false,
  });

  @override
  State<CompanyTreeItemNodeWidget> createState() => _CompanyTreeItemNodeWidgetState();
}

class _CompanyTreeItemNodeWidgetState extends State<CompanyTreeItemNodeWidget> {
  bool? _expanded;

  @override
  Widget build(BuildContext context) {
    final item = widget.itemNode.item;
    final itemNodes = widget.itemNode.nodes;
    final isExpandable = itemNodes.isNotEmpty;
    final itemIconPath = item.iconPath;

    final hasFilter = widget.filter != kEmptyCompanyTreeItemFilter;
    final matchesFilter = hasFilter && widget.itemNode.matchesFilter(widget.filter);
    final showExpanded = (_expanded == null && matchesFilter) || (_expanded != null && _expanded!);

    if (hasFilter && !matchesFilter) return SizedBox();
    return Padding(
      padding: widget.isRoot ? CustomSpacer.horizontal.md + CustomSpacer.top.sm : CustomSpacer.top.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CompanyTreeLevelIndicatorsWidget(
                isRoot: widget.isRoot,
                isExpandable: isExpandable,
                treeLevel: widget.itemNode.treeLevel,
              ),
              Flexible(
                child: InkWell(
                  onTap: isExpandable ? () => setState(() => _expanded = !showExpanded) : null,
                  borderRadius: BorderRadius.circular(CustomRadius.s),
                  child: Ink(
                    padding: CustomSpacer.right.xs,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isExpandable)
                          Padding(
                            padding: widget.isRoot ? EdgeInsets.zero : CustomSpacer.left.xxs,
                            child: Icon(
                              showExpanded ? Icons.expand_less_outlined : Icons.expand_more_outlined,
                              color: CustomColors.darkBlue,
                            ),
                          )
                        else if (widget.isRoot)
                          SizedBox(height: 24, width: 24),
                        if (itemIconPath != null)
                          Padding(
                            padding: CustomSpacer.left.xs,
                            child: itemIconPath == AppAssets.componentIconPng
                                ? CustomPngIcon(iconPath: itemIconPath)
                                : CustomSvgIcon(iconPath: itemIconPath),
                          ),
                        Flexible(
                          child: Padding(
                            padding: CustomSpacer.left.sm,
                            child: Text(
                              item.name,
                              style: CustomTextStyle.robotoBodyRegular.copyWith(color: CustomColors.darkBlue),
                            ),
                          ),
                        ),
                        if (item is CompanyAssetModel && item.sensorType.isEnergy)
                          Padding(
                            padding: CustomSpacer.left.xs,
                            child: CustomSvgIcon(iconPath: AppAssets.boltIconSvg, size: 16),
                          ),
                        if (item is CompanyAssetModel && item.status.isAlert)
                          Padding(
                            padding: CustomSpacer.left.xs,
                            child: CustomSvgIcon(iconPath: AppAssets.criticalIconSvg, size: 10),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isExpandable && showExpanded)
            ...itemNodes.map((itemNode) {
              return CompanyTreeItemNodeWidget(itemNode: itemNode, filter: widget.filter);
            }).toList(),
        ],
      ),
    );
  }
}
