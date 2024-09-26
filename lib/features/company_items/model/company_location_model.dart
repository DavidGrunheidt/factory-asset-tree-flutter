import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_company_item_model.dart';

part 'company_location_model.g.dart';

@CopyWith()
@JsonSerializable()
class CompanyLocationModel extends BaseCompanyItemModel {
  const CompanyLocationModel({
    required super.id,
    required super.name,
    super.parentId,
  });

  factory CompanyLocationModel.fromJson(Map<String, dynamic> json) => _$CompanyLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyLocationModelToJson(this);
}
