// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nduration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NDuration _$NDurationFromJson(Map<String, dynamic> json) => NDuration(
      value: _durationToNative(json['value']),
      viewId: json['viewId'] as int?,
    );

Map<String, dynamic> _$NDurationToJson(NDuration instance) => <String, dynamic>{
      'value': instance.value?.inMicroseconds,
      'viewId': instance.viewId,
    };
