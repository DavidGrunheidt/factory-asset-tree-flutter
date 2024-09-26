import 'package:flutter/material.dart';

import '../../../../core/constants/app_generic_constants.dart';
import '../../../../core/constants/app_widget_keys.dart';
import '../../../../core/design_system/theme/app_assets.dart';
import '../../../../core/design_system/theme/custom_colors.dart';
import '../../../../core/design_system/theme/custom_radius.dart';
import '../../../../core/design_system/theme/custom_text_style.dart';
import '../../../../core/design_system/widgets/custom_spacer.dart';
import '../../../../core/design_system/widgets/custom_svg_icon.dart';
import '../../model/company_tree_item_filter_model.dart';

class CompanyItemsFilterWidget extends StatefulWidget {
  final CompanyTreeItemFilterModel filter;
  final void Function(CompanyTreeItemFilterModel filter) onChanged;

  const CompanyItemsFilterWidget({
    super.key,
    required this.filter,
    required this.onChanged,
  });

  @override
  State<CompanyItemsFilterWidget> createState() => _CompanyItemsFilterWidgetState();
}

class _CompanyItemsFilterWidgetState extends State<CompanyItemsFilterWidget> {
  final searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filter = widget.filter;
    final filterBtnStyle = OutlinedButton.styleFrom(
      side: BorderSide(color: CustomColors.grey.withOpacity(0.5)),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: CustomColors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(CustomRadius.s),
      ),
    );

    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        pinned: true,
        floating: false,
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        surfaceTintColor: CustomColors.white,
        elevation: 0,
        collapsedHeight: kFiltersHeight,
        expandedHeight: kFiltersHeight,
        flexibleSpace: Padding(
          padding: CustomSpacer.top.sm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: CustomSpacer.horizontal.md,
                child: SearchBar(
                  key: kSearchBarTextInputKey,
                  controller: searchBarController,
                  padding: WidgetStateProperty.all(CustomSpacer.all.xs),
                  leading: InkWell(
                    key: kSearchBarSearchBtnKey,
                    onTap: () => widget.onChanged(
                      filter.copyWith(query: searchBarController.text, energySensor: false, criticalStatus: false),
                    ),
                    child: Icon(Icons.search_outlined, color: CustomColors.grey),
                  ),
                  trailing: [
                    InkWell(
                      onTap: () {
                        searchBarController.clear();
                        widget.onChanged(filter.copyWith(query: null));
                      },
                      child: Icon(
                        Icons.clear_outlined,
                        color: CustomColors.grey,
                      ),
                    ),
                  ],
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(CustomColors.lightGrey.withOpacity(0.5)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(CustomRadius.s)),
                  ),
                  hintText: 'Buscar Ativo ou Local',
                  textStyle: WidgetStateProperty.all(
                    CustomTextStyle.robotoBodyRegular.copyWith(color: CustomColors.grey),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (val) => widget.onChanged(
                    filter.copyWith(query: val, energySensor: false, criticalStatus: false),
                  ),
                ),
              ),
              Padding(
                padding: CustomSpacer.vertical.xs + CustomSpacer.horizontal.md,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: OutlinedButton(
                        key: kEnergySensorFilterBtnKey,
                        onPressed: () => widget.onChanged(filter.copyWith(energySensor: !filter.energySensor)),
                        style: filterBtnStyle.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                            filter.energySensor ? CustomColors.blue : Colors.transparent,
                          ),
                        ),
                        child: Padding(
                          padding: CustomSpacer.vertical.xxs,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomSvgIcon(
                                iconPath: AppAssets.boltOutlinedIconSvg,
                                color: filter.energySensor ? CustomColors.white : CustomColors.grey.withOpacity(0.6),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: CustomSpacer.left.xs,
                                  child: Text(
                                    'Sensor de energia',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyle.robotoMediumSm.copyWith(
                                      color: filter.energySensor ? CustomColors.white : CustomColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: CustomSpacer.left.sm,
                        child: OutlinedButton(
                          key: kAlertFilterBtnKey,
                          onPressed: () => widget.onChanged(filter.copyWith(criticalStatus: !filter.criticalStatus)),
                          style: filterBtnStyle.copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              filter.criticalStatus ? CustomColors.blue : Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: CustomSpacer.all.xxs,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color:
                                      filter.criticalStatus ? CustomColors.white : CustomColors.grey.withOpacity(0.6),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: CustomSpacer.left.xs,
                                    child: Text(
                                      'Critico',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.robotoMediumSm.copyWith(
                                        color: filter.criticalStatus ? CustomColors.white : CustomColors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: CustomColors.grey, thickness: 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
