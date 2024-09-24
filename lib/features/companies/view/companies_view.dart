import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/constants/app_widget_keys.dart';
import '../../../core/dependencies/dependency_injector.dart';
import '../../../core/design_system/theme/app_assets.dart';
import '../../../core/design_system/theme/custom_colors.dart';
import '../../../core/design_system/theme/custom_radius.dart';
import '../../../core/design_system/theme/custom_text_style.dart';
import '../../../core/design_system/widgets/custom_spacer.dart';
import '../../../core/design_system/widgets/custom_svg_icon.dart';
import '../../../core/design_system/widgets/tractian_logo_svg.dart';
import '../../../core/helpers/snackbar_helper.dart';
import '../../base_view_model_container.dart';
import 'companies_view_model.dart';

@RoutePage()
class CompaniesView extends StatefulWidget {
  final CompaniesViewModel? viewModel;

  const CompaniesView({
    super.key,
    this.viewModel,
  });

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  late final _viewModel = widget.viewModel ?? getIt<CompaniesViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkBlue,
        title: TractianLogoSvg(),
      ),
      body: BaseViewModelContainer(
        viewModel: _viewModel,
        child: Observer(builder: (context) {
          final companies = _viewModel.companies;
          return Scrollbar(
            thumbVisibility: true,
            child: RefreshIndicator(
              onRefresh: () => _viewModel.init(),
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                slivers: [
                  if (companies.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          key: kNoCompaniesAvailableTextKey,
                          'No companies available',
                          style: CustomTextStyle.headlineLarge.copyWith(color: CustomColors.darkBlue),
                        ),
                      ),
                    )
                  else
                    SliverList.builder(
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final company = companies[index];
                        return Padding(
                          padding: index == 0
                              ? CustomSpacer.all.md.copyWith(top: CustomSpacer.top.lg.top)
                              : CustomSpacer.all.md,
                          child: Card(
                            color: CustomColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(CustomRadius.s),
                            ),
                            child: InkWell(
                              onTap: () => showSnackbar(context: context, content: 'Oi'),
                              borderRadius: BorderRadius.circular(CustomRadius.s),
                              child: Ink(
                                padding: CustomSpacer.all.xmd,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: CustomSpacer.right.md,
                                      child: CustomSvgIcon(iconPath: AppAssets.treeIconSvg),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${company.name} Unit',
                                        style: CustomTextStyle.robotoMediumLg.copyWith(color: CustomColors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
