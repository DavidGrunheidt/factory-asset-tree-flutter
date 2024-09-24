import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/asset_tree_app.dart';
import 'package:factory_asset_tree_flutter/core/dependencies/app_router_locator.dart';
import 'package:factory_asset_tree_flutter/core/dependencies/dependency_injector.dart';
import 'package:factory_asset_tree_flutter/core/router/app_router.dart';
import 'package:factory_asset_tree_flutter/features/companies/repository/companies_repository.dart';
import 'package:factory_asset_tree_flutter/features/companies/service/companies_service.dart';
import 'package:factory_asset_tree_flutter/features/companies/view/companies_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../data/mocks/mocks_generator.mocks.dart';
import '../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompaniesViewModel', () {
    final mockApiClient = MockTractianApiClient();

    final companiesService = CompaniesServiceImpl(mockApiClient);

    late CompaniesRepository companiesRepository;
    late CompaniesViewModel companiesViewModel;

    Future<Response> getCompanies() => mockApiClient.get('/companies');

    Future<void> pumpAssetTreeAppView(WidgetTester tester) async {
      tester.view.physicalSize = iphoneProMaxScreenSize;
      await tester.pumpWidget(AssetTreeApp());
      await tester.pumpAndSettle();
    }

    setUp(() {
      companiesRepository = CompaniesRepository(companiesService);
      companiesViewModel = CompaniesViewModel(companiesRepository);

      getIt.registerFactory<CompaniesViewModel>(() => companiesViewModel);
    });

    tearDown(() {
      reset(mockApiClient);
      getIt.reset();
    });

    testWidgets('initial page is CompaniesView', (tester) async {
      when(getCompanies()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));
      await pumpAssetTreeAppView(tester);

      final router = globalAppRouter;

      expect(router.stack.first.name, CompaniesRoute.name);
      verify(getCompanies());
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
