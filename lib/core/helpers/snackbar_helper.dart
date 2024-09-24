import 'package:flutter/material.dart';

import '../design_system/theme/custom_colors.dart';
import '../design_system/widgets/custom_spacer.dart';

void showSnackbar({
  Key? key,
  required BuildContext context,
  required String content,
  Duration duration = const Duration(seconds: 5),
}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.hideCurrentSnackBar();
  scaffoldMessenger.showSnackBar(
    SnackBar(
      key: key,
      behavior: SnackBarBehavior.fixed,
      padding: CustomSpacer.all.md,
      backgroundColor: CustomColors.black16,
      content: Row(
        children: [
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.white),
            ),
          ),
          Padding(
            padding: CustomSpacer.left.xs,
            child: InkWell(
              onTap: scaffoldMessenger.hideCurrentSnackBar,
              child: const Icon(Icons.close_outlined, color: CustomColors.white),
            ),
          ),
        ],
      ),
      duration: duration,
    ),
  );
}

void showCurrentlyDisabledSnackbar(BuildContext context) {
  return showSnackbar(
    context: context,
    content: 'Ops! This feature can\'t be used at this moment',
  );
}
