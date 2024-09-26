import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/constants/app_widget_keys.dart';
import '../../../core/dependencies/dependency_injector.dart';
import '../../../core/design_system/theme/custom_colors.dart';
import '../../../core/design_system/theme/custom_text_style.dart';
import '../../../core/design_system/widgets/custom_spacer.dart';
import '../../../core/design_system/widgets/tractian_logo_svg.dart';
import '../../base_view_model_container.dart';
import 'companies_view_model.dart';
import 'widgets/company_card_widget.dart';

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
              onRefresh: () async => unawaited(_viewModel.init()),
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                slivers: [
                  if (!_viewModel.loading && companies.isEmpty)
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
                        return Padding(
                          padding: index == 0
                              ? CustomSpacer.all.md.copyWith(top: CustomSpacer.top.lg.top)
                              : CustomSpacer.all.md,
                          child: CompanyCardWidget(company: companies[index]),
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
