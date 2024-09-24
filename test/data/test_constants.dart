//Resolutions
import 'package:dio/dio.dart';
import 'package:factory_asset_tree_flutter/features/companies/model/company_model.dart';
import 'package:flutter/material.dart';

import 'json_utils.dart';

const iphoneProMaxScreenSize = Size(1290, 2796);

// HTTP Requests
final dioException = DioException(requestOptions: RequestOptions());
final reqOpts = RequestOptions();

// Companies
final companiesJson = jsonListFromFile('./test/data/jsons/get_companies_resp.json');

final expectedCompanies = companiesJson.map(CompanyModel.fromJson).toList();
