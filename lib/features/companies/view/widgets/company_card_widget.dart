import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/design_system/theme/app_assets.dart';
import '../../../../core/design_system/theme/custom_colors.dart';
import '../../../../core/design_system/theme/custom_radius.dart';
import '../../../../core/design_system/theme/custom_text_style.dart';
import '../../../../core/design_system/widgets/custom_spacer.dart';
import '../../../../core/design_system/widgets/custom_svg_icon.dart';
import '../../../../core/router/app_router.dart';
import '../../model/company_model.dart';

class CompanyCardWidget extends StatelessWidget {
  final CompanyModel company;

  const CompanyCardWidget({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CustomRadius.s),
      ),
      child: InkWell(
        onTap: () => context.pushRoute(CompanyItemsRoute(companyId: company.id)),
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
    );
  }
}
