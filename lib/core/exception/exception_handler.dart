import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../dependencies/error_handler_context_locator.dart';
import '../helpers/snackbar_helper.dart';
import 'app_exception_codes.dart';
import 'app_internal_error.dart';
import 'ui_error_alerts_map.dart';

void handleAppInternalError(AppInternalError exception) {
  final message = uiErrorAlerts[exception.code];
  return message == null || message.isEmpty ? null : _showErrorMessage(message);
}

void handleUnexpectedDioException(DioException error, StackTrace? stack) {
  switch (error.type) {
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionTimeout:
      return handleAppInternalError(const AppInternalError(code: kDioTimeoutErrorKey));
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      return handleAppInternalError(const AppInternalError(code: kCheckInternetConnectionErrorKey));
    default:
      return;
  }
}

void reportErrorDetails(FlutterErrorDetails flutterErrorDetails) {
  const errors = <String>['rendering library', 'widgets library'];

  final isSilentOnRelease = kReleaseMode && flutterErrorDetails.silent;
  final isLibraryOnDebug = !kReleaseMode && errors.contains(flutterErrorDetails.library);
  if (isSilentOnRelease || isLibraryOnDebug) {
    log(
      flutterErrorDetails.exceptionAsString(),
      name: 'ReportErrorDetails',
      stackTrace: flutterErrorDetails.stack,
      error: flutterErrorDetails.exception,
    );
  }

  return reportErrorToUI(flutterErrorDetails.exception, flutterErrorDetails.stack);
}

void reportErrorToUI(Object error, StackTrace? stackTrace) {
  if (error is DioException) return handleUnexpectedDioException(error, stackTrace);
  if (error is AppInternalError) return handleAppInternalError(error);
}

void _showErrorMessage(String message) {
  final context = getGlobalErrorHandlerContext();
  return showSnackbar(context: context, content: message);
}
