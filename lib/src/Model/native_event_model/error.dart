import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class Error {
  String? value;
  int? viewId;

  Error({this.value, this.viewId});

  @override
  String toString() => 'Error(value: $value, viewId: $viewId)';

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
