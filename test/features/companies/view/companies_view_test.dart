import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/core/constants/app_widget_keys.dart';
import 'package:factory_asset_tree_flutter/core/router/app_router.dart';
import 'package:factory_asset_tree_flutter/features/companies/repository/companies_repository.dart';
import 'package:factory_asset_tree_flutter/features/companies/service/companies_service.dart';
import 'package:factory_asset_tree_flutter/features/companies/view/companies_view.dart';
import 'package:factory_asset_tree_flutter/features/companies/view/companies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompaniesViewModel', () {
    final mockStackRouter = MockStackRouter();
    final mockApiClient = MockTractianApiClient();

    final companiesService = CompaniesServiceImpl(mockApiClient);

    late CompaniesRepository companiesRepository;
    late CompaniesViewModel companiesViewModel;

    Future<Response> getCompanies() => mockApiClient.get('/companies');

    Future<void> pumpCompaniesView(WidgetTester tester) async {
      tester.view.physicalSize = iphoneProMaxScreenSize;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: StackRouterScope(
              controller: mockStackRouter,
              stateHash: 0,
              child: CompaniesView(viewModel: companiesViewModel),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
    }

    setUp(() {
      companiesRepository = CompaniesRepository(companiesService);
      companiesViewModel = CompaniesViewModel(companiesRepository);
    });

    tearDown(() {
      reset(mockApiClient);
      reset(mockStackRouter);
    });

    testWidgets('shows no companies available message', (tester) async {
      when(getCompanies()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));
      await pumpCompaniesView(tester);

      expect(find.byKey(kNoCompaniesAvailableTextKey), findsOneWidget);
      expect(find.textContaining('Unit'), findsNothing);
      expect(companiesViewModel.loading, false);
      expect(companiesViewModel.companies, []);
      verify(getCompanies());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('shows all companies names', (tester) async {
      when(getCompanies()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companiesJson));
      await pumpCompaniesView(tester);

      expectedCompanies.forEach((company) {
        expect(find.textContaining(company.name), findsAtLeastNWidgets(1));
      });

      expect(find.byKey(kNoCompaniesAvailableTextKey), findsNothing);
      expect(companiesViewModel.loading, false);
      expect(companiesViewModel.companies, expectedCompanies);
      verify(getCompanies());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('click on company goes to company asset page', (tester) async {
      Future<void> pushCompanyAssetsRoute() => mockStackRouter.push(
            CompanyItemsRoute(companyId: expectedCompanies.first.id),
          );

      when(getCompanies()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companiesJson));
      when(pushCompanyAssetsRoute()).thenAnswer((_) async {});
      await pumpCompaniesView(tester);

      final firstCompanyBtn = find.textContaining(expectedCompanies.first.name);
      await tester.tap(firstCompanyBtn);
      await tester.pumpAndSettle();

      verify(getCompanies());
      verify(pushCompanyAssetsRoute());
      verifyNoMoreInteractions(mockApiClient);
      verifyNoMoreInteractions(mockStackRouter);
    });
  });
}
