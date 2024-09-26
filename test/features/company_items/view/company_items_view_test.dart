import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/core/constants/app_widget_keys.dart';
import 'package:factory_asset_tree_flutter/core/design_system/theme/app_assets.dart';
import 'package:factory_asset_tree_flutter/core/design_system/widgets/custom_svg_icon.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/base_company_item_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/repository/company_items_repository.dart';
import 'package:factory_asset_tree_flutter/features/company_items/service/company_items_service.dart';
import 'package:factory_asset_tree_flutter/features/company_items/view/company_items_view.dart';
import 'package:factory_asset_tree_flutter/features/company_items/view/company_items_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mocks/mocks_generator.mocks.dart';
import '../../../data/test_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CompanyItemsViewtest', () {
    final mockStackRouter = MockStackRouter();
    final mockApiClient = MockTractianApiClient();

    final companyItemsService = CompanyItemsServiceImpl(mockApiClient);

    late CompanyItemsRepository companyItemsRepository;
    late CompanyItemsViewModel companyItemsViewModel;

    Future<Response> getCompanyLocations() => mockApiClient.get('/companies/$companyId/locations');
    Future<Response> getCompanyAssets() => mockApiClient.get('/companies/$companyId/assets');

    Future<void> pumpCompanyItemsView(WidgetTester tester) async {
      tester.view.physicalSize = iphoneProMaxScreenSize;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: StackRouterScope(
              controller: mockStackRouter,
              stateHash: 0,
              child: CompanyItemsView(
                companyId: companyId,
                viewModel: companyItemsViewModel,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
    }

    setUp(() {
      companyItemsRepository = CompanyItemsRepository(companyItemsService);
      companyItemsViewModel = CompanyItemsViewModel(companyItemsRepository);
    });

    tearDown(() {
      reset(mockApiClient);
      reset(mockStackRouter);
    });

    testWidgets('shows no items available message when locations and assets are empty', (tester) async {
      when(getCompanyLocations()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: []));

      await pumpCompanyItemsView(tester);

      expect(find.byKey(kNoAssetsAvailableForCompanyTextKey), findsOneWidget);
      expect(find.textContaining('Unit'), findsNothing);
      expect(companyItemsViewModel.loading, false);
      expect(companyItemsViewModel.companyItems, []);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('starts showing only root items', (tester) async {
      when(getCompanyLocations())
          .thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyLocationsJson));
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyAssetsJson));

      await pumpCompanyItemsView(tester);
      expectedCompanyItems.forEach(
        (item) => item.isRoot
            ? expect(find.text(item.name), findsAtLeastNWidgets(1))
            : expect(find.text(item.name), findsNothing),
      );

      expect(find.byKey(kNoAssetsAvailableForCompanyTextKey), findsNothing);
      expect(companyItemsViewModel.loading, false);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('click on first item expands it', (tester) async {
      when(getCompanyLocations())
          .thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyLocationsJson));
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyAssetsJson));

      await pumpCompanyItemsView(tester);

      final firstRootNode = expectedCompanyItemsTree.first;
      firstRootNode.nodes.forEach((itemNode) => expect(find.text(itemNode.item.name), findsNothing));

      final firstRootWidgetFinder = find.text(firstRootNode.item.name);
      await tester.tap(firstRootWidgetFinder);
      await tester.pumpAndSettle();

      firstRootNode.nodes.forEach((itemNode) => expect(find.text(itemNode.item.name), findsAtLeastNWidgets(1)));

      expect(companyItemsViewModel.loading, false);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('click on energy sensor filter shows only energy items', (tester) async {
      when(getCompanyLocations())
          .thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyLocationsJson));
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyAssetsJson));

      await pumpCompanyItemsView(tester);

      expect(
        find.byWidgetPredicate((el) => el is CustomSvgIcon && el.iconPath == AppAssets.boltIconSvg),
        findsNothing,
      );

      final energySensorBtnFinder = find.byKey(kEnergySensorFilterBtnKey);
      await tester.tap(energySensorBtnFinder);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate((el) => el is CustomSvgIcon && el.iconPath == AppAssets.boltIconSvg),
        findsAtLeastNWidgets(1),
      );

      expect(companyItemsViewModel.loading, false);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('click on alert sensor filter shows only alert items', (tester) async {
      when(getCompanyLocations())
          .thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyLocationsJson));
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyAssetsJson));

      await pumpCompanyItemsView(tester);

      expect(
        find.byWidgetPredicate((el) => el is CustomSvgIcon && el.iconPath == AppAssets.criticalIconSvg),
        findsNothing,
      );

      final energySensorBtnFinder = find.byKey(kAlertFilterBtnKey);
      await tester.tap(energySensorBtnFinder);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate((el) => el is CustomSvgIcon && el.iconPath == AppAssets.criticalIconSvg),
        findsAtLeastNWidgets(1),
      );

      expect(companyItemsViewModel.loading, false);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });

    testWidgets('search query shows only items that contains query string', (tester) async {
      final query = 'Sensor 28';

      when(getCompanyLocations())
          .thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyLocationsJson));
      when(getCompanyAssets()).thenAnswer((_) async => Response(requestOptions: reqOpts, data: companyAssetsJson));

      await pumpCompanyItemsView(tester);
      expect(find.textContaining(query), findsNothing);

      final searchBarTextInputFinder = find.byKey(kSearchBarTextInputKey);
      final searchBarSearchBtnFinder = find.byKey(kSearchBarSearchBtnKey);

      await tester.enterText(searchBarTextInputFinder, query);
      await tester.pumpAndSettle();

      await tester.tap(searchBarSearchBtnFinder);
      await tester.pumpAndSettle();

      expect(find.textContaining(query), findsAtLeastNWidgets(1));

      expect(companyItemsViewModel.loading, false);
      verify(getCompanyLocations());
      verify(getCompanyAssets());
      verifyNoMoreInteractions(mockApiClient);
      verifyZeroInteractions(mockStackRouter);
    });
  });
}
