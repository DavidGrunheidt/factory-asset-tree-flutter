import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../core/constants/app_generic_constants.dart';
import '../../../core/constants/app_widget_keys.dart';
import '../../../core/dependencies/dependency_injector.dart';
import '../../../core/design_system/theme/custom_colors.dart';
import '../../../core/design_system/theme/custom_text_style.dart';
import '../../../core/design_system/widgets/custom_spacer.dart';
import '../../base_view_model_container.dart';
import 'company_items_view_model.dart';
import 'widgets/company_items_filter_widget.dart';
import 'widgets/company_tree_item_node_widget.dart';

@RoutePage()
class CompanyItemsView extends StatefulWidget {
  final String companyId;
  final CompanyItemsViewModel? viewModel;

  const CompanyItemsView({
    super.key,
    @PathParam('id') required this.companyId,
    this.viewModel,
  });

  @override
  State<CompanyItemsView> createState() => _CompanyItemsViewState();
}

class _CompanyItemsViewState extends State<CompanyItemsView> {
  late final _viewModel = widget.viewModel ?? getIt<CompanyItemsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkBlue,
        title: Text('Assets'),
      ),
      body: BaseViewModelContainer(
        beforeInit: () => _viewModel.companyId = widget.companyId,
        viewModel: _viewModel,
        child: NestedScrollView(
          floatHeaderSlivers: false,
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, _) => [
            Observer(builder: (context) {
              return CompanyItemsFilterWidget(
                filter: _viewModel.filter,
                onChanged: (filter) => _viewModel.filter = filter,
              );
            }),
          ],
          body: Observer(builder: (context) {
            final companyItemsTree = _viewModel.companyItemsTree;
            return Padding(
              padding: EdgeInsets.only(top: kFiltersHeight),
              child: Scrollbar(
                thumbVisibility: true,
                child: RefreshIndicator(
                  onRefresh: () async => unawaited(_viewModel.init()),
                  child: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                    slivers: [
                      if (!_viewModel.loading && companyItemsTree.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: CustomSpacer.all.md,
                            child: Center(
                              child: Text(
                                key: kNoAssetsAvailableForCompanyTextKey,
                                'No locations and assets found for this company.',
                                style: CustomTextStyle.headlineLarge.copyWith(color: CustomColors.darkBlue),
                              ),
                            ),
                          ),
                        ),
                      MultiSliver(
                        children: [
                          ...companyItemsTree.mapIndexed((index, itemNode) {
                            return CompanyTreeItemNodeWidget(
                              itemNode: itemNode,
                              filter: _viewModel.filter,
                              isRoot: true,
                            );
                          }).toList(),
                          SliverToBoxAdapter(
                            child: SizedBox(height: CustomSpacer.bottom.xlg.bottom),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
