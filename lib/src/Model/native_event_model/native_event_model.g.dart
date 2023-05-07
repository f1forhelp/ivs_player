// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeEventModel _$NativeEventModelFromJson(Map<String, dynamic> json) =>
    NativeEventModel(
      state: json['state'] == null
          ? null
          : State.fromJson(json['state'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : NDuration.fromJson(json['duration'] as Map<String, dynamic>),
      error: json['error'] == null
          ? null
          : Error.fromJson(json['error'] as Map<String, dynamic>),
      quality: json['quality'] == null
          ? null
          : Quality.fromJson(json['quality'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NativeEventModelToJson(NativeEventModel instance) =>
    <String, dynamic>{
      'state': instance.state,
      'duration': instance.duration,
      'error': instance.error,
      'quality': instance.quality,
    };
