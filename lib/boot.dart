import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'asset_tree_app.dart';
import 'core/dependencies/dependency_injector.dart';
import 'core/exception/exception_handler.dart';

Future<void> boot() async {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();

    FlutterError.onError = (details) async {
      FlutterError.presentError(details);
      return reportErrorDetails(details);
    };

    if (!kIsWeb) {
      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        final error = errorAndStacktrace.first;
        final stack = StackTrace.fromString(errorAndStacktrace.last.toString());
        return reportErrorToUI(error, stack);
      }).sendPort);
    }

    runApp(AssetTreeApp());
  }, (error, stack) async {
    if (kDebugMode) debugPrint('Unhandled Error: $error StackTrace: $stack');
    return reportErrorToUI(error, stack);
  });
}
