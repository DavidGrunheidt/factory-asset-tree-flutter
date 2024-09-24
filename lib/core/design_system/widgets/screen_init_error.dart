import 'package:flutter/material.dart';

import 'custom_spacer.dart';

class ScreenInitError extends StatelessWidget {
  final VoidCallback onTryAgain;
  final bool allowRetry;
  final String initErrorReason;

  const ScreenInitError({
    super.key,
    required this.allowRetry,
    required this.onTryAgain,
    required this.initErrorReason,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomSpacer.all.md,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(initErrorReason, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            if (allowRetry)
              TextButton(
                onPressed: onTryAgain,
                child: Text('Try again'),
              )
            else
              const Text('Try again later', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
