import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/dependencies/app_router_locator.dart';
import 'core/dependencies/error_handler_context_locator.dart';
import 'core/design_system/theme/theme_data.dart';
import 'core/router/app_router.dart';

class AssetTreeApp extends StatefulWidget {
  const AssetTreeApp({super.key});

  @override
  State<AssetTreeApp> createState() => _AssetTreeAppState();
}

class _AssetTreeAppState extends State<AssetTreeApp> {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
    registerGlobalErrorHandlerContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        registerGlobalAppRouter(_router);
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.3);
        return MediaQuery(
          data: mediaQueryData.copyWith(textScaler: scale),
          child: child!,
        );
      },
      title: 'Asset Tree',
      routerConfig: _router.config(),
      theme: themeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: !kDebugMode,
    );
  }
}
