import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../core/exception/app_internal_error.dart';
import '../core/exception/exception_handler.dart';
import '../core/exception/ui_error_alerts_map.dart';

part 'base_view_model.g.dart';

class BaseViewModel = _BaseViewModel with _$BaseViewModel;

abstract class _BaseViewModel with Store {
  @observable
  var loading = false;

  @observable
  var firstLoading = true;

  @observable
  var initFailed = false;

  @computed
  bool get maxRetriesReached => initRetryCounter > 5;

  @observable
  var initRetryCounter = 0;

  @computed
  bool get allowInitRetry => !maxRetriesReached;

  @observable
  String? initErrorReason;

  @action
  @nonVirtual
  Future<void> runInit() async {
    try {
      initFailed = false;
      await init();
      initRetryCounter = 0;
    } catch (exception, stack) {
      debugPrint('Error initilializing viewModel: ${exception.toString()}:\n$stack');

      if (exception is AppInternalError) {
        if (!exception.isCritical) return handleAppInternalError(exception);
        initErrorReason = uiErrorAlerts[exception.code];
      }

      initFailed = true;
      initRetryCounter++;
    } finally {
      firstLoading = false;
      loading = false;
    }
  }

  @action
  @protected
  Future<void> init() async {}

  void dispose() {}
}
