import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_tree_item_filter_model.g.dart';

@CopyWith()
class CompanyTreeItemFilterModel extends Equatable {
  final String? query;
  final bool energySensor;
  final bool criticalStatus;

  const CompanyTreeItemFilterModel({
    this.query,
    this.energySensor = false,
    this.criticalStatus = false,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [query, energySensor, criticalStatus];
}
