import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/dependencies/dependency_injector.dart';
import 'company_asset_view_model.dart';

@RoutePage()
class CompanyAssetView extends StatefulWidget {
  final CompanyAssetViewModel? viewModel;

  const CompanyAssetView({
    super.key,
    this.viewModel,
  });

  @override
  State<CompanyAssetView> createState() => _CompanyAssetViewState();
}

class _CompanyAssetViewState extends State<CompanyAssetView> {
  // ignore: unused_field
  late final _viewModel = widget.viewModel ?? getIt<CompanyAssetViewModel>();

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
