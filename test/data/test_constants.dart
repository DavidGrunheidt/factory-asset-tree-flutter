//Resolutions
import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/features/companies/model/company_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/base_company_item_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_asset_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_location_model.dart';
import 'package:factory_asset_tree_flutter/features/company_items/model/company_tree_item_node_model.dart';
import 'package:flutter/material.dart';

import 'json_utils.dart';

const iphoneProMaxScreenSize = Size(1290, 2796);

// HTTP Requests
final dioException = DioException(requestOptions: RequestOptions());
final reqOpts = RequestOptions();

// Companies
final companyId = '662fd0fab3fd5656edb39af5';
final companiesJson = jsonListFromFile('./test/data/jsons/get_companies_resp.json');
final companyLocationsJson = jsonListFromFile('./test/data/jsons/get_company_locations_resp.json');
final companyAssetsJson = jsonListFromFile('./test/data/jsons/get_company_assets_resp.json');

final expectedCompanies = companiesJson.map(CompanyModel.fromJson).toList();
final expectedCompanyLocations = companyLocationsJson.map(CompanyLocationModel.fromJson).toList();
final expectedCompanyAssets = companyAssetsJson.map(CompanyAssetModel.fromJson).toList();

final expectedCompanyItems = <BaseCompanyItemModel>[...expectedCompanyLocations, ...expectedCompanyAssets];
final expectedCompanyItemsTree = getItemsTree(expectedCompanyItems);
