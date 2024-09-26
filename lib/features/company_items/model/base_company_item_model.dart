import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/design_system/theme/app_assets.dart';
import 'company_asset_model.dart';
import 'company_location_model.dart';

abstract class BaseCompanyItemModel extends Equatable {
  @JsonKey(includeToJson: false)
  final String id;
  final String name;
  final String? parentId;

  const BaseCompanyItemModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory BaseCompanyItemModel.fromJson(Map<String, dynamic> json) => throw UnimplementedError();

  Map<String, dynamic> toJson() => throw UnimplementedError();

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [id, name, parentId];
}

extension BaseCompanyItemModelExtension on BaseCompanyItemModel {
  String? get iconPath {
    final companyItem = this;
    if (companyItem is CompanyLocationModel) return AppAssets.locationIconSvg;
    if (companyItem is CompanyAssetModel) {
      return companyItem.sensorType == null ? AppAssets.assetIconSvg : AppAssets.componentIconPng;
    }

    return null;
  }

  bool get isRoot {
    final item = this;
    return item is CompanyLocationModel && item.parentId == null ||
        item is CompanyAssetModel && item.parentId == null && item.locationId == null;
  }
}
