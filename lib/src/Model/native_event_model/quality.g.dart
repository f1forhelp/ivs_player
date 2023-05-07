// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quality _$QualityFromJson(Map<String, dynamic> json) => Quality(
      width: json['width'] as int?,
      height: json['height'] as int?,
      name: json['name'] as String?,
    )..viewId = json['viewId'] as int?;

Map<String, dynamic> _$QualityToJson(Quality instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'name': instance.name,
      'viewId': instance.viewId,
    };
