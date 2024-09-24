import 'package:flutter/material.dart';

import 'dependency_injector.dart';

const errorHandlerContextInstanceName = 'errorHandlerContext';

void registerGlobalErrorHandlerContext(BuildContext context) {
  getIt.registerSingleton<BuildContext>(context, instanceName: errorHandlerContextInstanceName);
}

BuildContext getGlobalErrorHandlerContext() {
  return getIt<BuildContext>(instanceName: errorHandlerContextInstanceName);
}
