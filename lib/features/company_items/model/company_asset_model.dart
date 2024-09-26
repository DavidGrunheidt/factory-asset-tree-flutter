import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum/sensor_status_enum.dart';
import '../enum/sensor_type_enum.dart';
import 'base_company_item_model.dart';

part 'company_asset_model.g.dart';

@CopyWith()
@JsonSerializable()
class CompanyAssetModel extends BaseCompanyItemModel {
  final String? sensorId;
  final SensorTypeEnum? sensorType;
  final SensorStatusEnum? status;
  final String? gatewayId;
  final String? locationId;

  const CompanyAssetModel({
    required super.id,
    required super.name,
    super.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
  });

  factory CompanyAssetModel.fromJson(Map<String, dynamic> json) => _$CompanyAssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyAssetModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [...super.props, sensorId, sensorType, status, gatewayId, locationId];
}
