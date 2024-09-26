// Injectable named tags
import 'dart:io';

import 'package:flutter/material.dart';

import '../../features/company_items/model/company_tree_item_filter_model.dart';

const kTractianApiClient = 'tractianApiClient';

// Sizes
const kFiltersHeight = kToolbarHeight + 92;

// Others
const kGenericExceptionMessage = 'Oh no! Something went wrong.';
const kEmptyCompanyTreeItemFilter = CompanyTreeItemFilterModel();

// Sizes
late final isRunningTests = Platform.environment.containsKey('FLUTTER_TEST');
