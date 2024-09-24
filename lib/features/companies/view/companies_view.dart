import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/dependencies/dependency_injector.dart';
import '../../../core/design_system/theme/custom_colors.dart';
import '../../../core/design_system/widgets/custom_spacer.dart';
import '../../../core/design_system/widgets/tractian_logo_svg.dart';
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
        child: SingleChildScrollView(
          padding: CustomSpacer.all.xmd,
          physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
