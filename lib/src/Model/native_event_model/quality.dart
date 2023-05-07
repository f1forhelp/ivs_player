import 'package:json_annotation/json_annotation.dart';

part 'quality.g.dart';

@JsonSerializable()
class Quality {
  int? width;
  int? height;
  String? name;
  int? viewId;

  Quality({this.width, this.height, this.name});

  @override
  String toString() {
    return 'Quality(width: $width, height: $height, name: $name , viewId:$viewId)';
  }

  factory Quality.fromJson(Map<String, dynamic> json) {
    return _$QualityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QualityToJson(this);
}
