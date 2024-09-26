import 'package:flutter/material.dart';

import '../../../../core/design_system/theme/custom_colors.dart';
import '../../../../core/design_system/widgets/custom_spacer.dart';

class CompanyTreeLevelIndicatorsWidget extends StatelessWidget {
  final bool isRoot;
  final bool isExpandable;
  final int treeLevel;

  const CompanyTreeLevelIndicatorsWidget({
    super.key,
    required this.isRoot,
    required this.isExpandable,
    required this.treeLevel,
  });

  @override
  Widget build(BuildContext context) {
    if (isRoot) return SizedBox();

    final treeLevelIndications = isExpandable ? treeLevel : treeLevel + 1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(treeLevelIndications, (index) {
        final isLastLevel = !isExpandable && index == treeLevelIndications - 1;
        return Padding(
          padding: index == 0
              ? CustomSpacer.left.xxs
              : isLastLevel
                  ? CustomSpacer.left.sm
                  : CustomSpacer.left.xs,
          child: SizedBox(
            height: 20,
            child: VerticalDivider(color: CustomColors.grey, thickness: 0.4),
          ),
        );
      }),
    );
  }
}
