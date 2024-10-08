import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/companies/view/companies_view.dart';
import '../../features/companies/view/companies_view_model.dart';
import '../../features/company_items/view/company_items_view.dart';
import '../../features/company_items/view/company_items_view_model.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/companies', page: CompaniesRoute.page, initial: true),
        AutoRoute(path: '/company_items', page: CompanyItemsRoute.page),
      ];
}
