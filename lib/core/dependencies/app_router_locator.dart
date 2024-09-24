import 'package:flutter/cupertino.dart';

import '../router/app_router.dart';
import 'dependency_injector.dart';

@visibleForTesting
const appRouterInstanceName = 'tabsRouter';

void registerGlobalAppRouter(AppRouter appRouter) {
  if (getIt.isRegistered<AppRouter>(instanceName: appRouterInstanceName)) return;
  getIt.registerSingleton<AppRouter>(appRouter, instanceName: appRouterInstanceName);
}

AppRouter get globalAppRouter => getIt<AppRouter>(instanceName: appRouterInstanceName);
