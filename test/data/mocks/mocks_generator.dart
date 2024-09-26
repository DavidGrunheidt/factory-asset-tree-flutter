import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/core/apli_clients/tractian_api_client.dart';
import 'package:factory_asset_tree_flutter/features/companies/repository/companies_repository.dart';
import 'package:factory_asset_tree_flutter/features/companies/service/companies_service.dart';
import 'package:factory_asset_tree_flutter/features/company_items/repository/company_items_repository.dart';
import 'package:factory_asset_tree_flutter/features/company_items/service/company_items_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CompaniesService,
  CompanyItemsService,
])
// ignore: unused_element
void _generateServices() {}

@GenerateMocks([
  CompaniesRepository,
  CompanyItemsRepository,
])
// ignore: unused_element
void _generateRepositories() {}

@GenerateMocks([
  RequestInterceptorHandler,
  ErrorInterceptorHandler,
  StackRouter,
  TractianApiClient,
  Dio,
])
// ignore: unused_element
void _generateOtherMocks() {}
