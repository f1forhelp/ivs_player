import 'package:json_annotation/json_annotation.dart';

part 'nduration.g.dart';

@JsonSerializable()
class NDuration {
  @JsonKey(fromJson: _durationToNative)
  Duration? value;
  int? viewId;

  NDuration({this.value, this.viewId});

  @override
  String toString() => 'Duration(value: $value, viewId: $viewId)';

  factory NDuration.fromJson(Map<String, dynamic> json) {
    return _$NDurationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NDurationToJson(this);
}

_durationToNative(v) {
  double d = double.tryParse(v.toString()) ?? 0.0;
  return Duration(seconds: d.round());
}
