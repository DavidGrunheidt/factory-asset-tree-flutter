import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/constants/app_generic_constants.dart';
import '../core/design_system/widgets/custom_loading_widget.dart';
import '../core/design_system/widgets/screen_init_error.dart';
import 'base_view_model.dart';

class BaseViewModelContainer extends StatefulWidget {
  final BaseViewModel viewModel;
  final VoidCallback? beforeInit;
  final VoidCallback? afterInit;
  final Widget child;

  const BaseViewModelContainer({
    super.key,
    required this.viewModel,
    required this.child,
    this.beforeInit,
    this.afterInit,
  });

  @override
  State<BaseViewModelContainer> createState() => _BaseViewModelContainerState();
}

// TODO(DavidGrunheidt): Revisit this implementation once he start hiting endpoints on init function
// of viewModels
class _BaseViewModelContainerState extends State<BaseViewModelContainer> {
  @override
  void initState() {
    super.initState();

    widget.beforeInit?.call();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.viewModel.runInit();
      return widget.afterInit?.call();
    });
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

  Widget get loadingScreen => CustomLoadingWidget(height: MediaQuery.sizeOf(context).height);

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    return GestureDetector(
      onTap: () => closeKeyboard(context),
      child: Observer(
        builder: (context) {
          return Stack(
            children: [
              if (viewModel.initFailed)
                ScreenInitError(
                  allowRetry: viewModel.allowInitRetry,
                  onTryAgain: viewModel.runInit,
                  initErrorReason: viewModel.initErrorReason ?? kGenericExceptionMessage,
                ),
              if (!viewModel.initFailed) widget.child,
              if (viewModel.loading) loadingScreen,
            ],
          );
        },
      ),
    );
  }
}
