// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

State _$StateFromJson(Map<String, dynamic> json) => State(
      value: _mapPlayerStateEnum(json['value']),
      viewId: json['viewId'] as int?,
    );

Map<String, dynamic> _$StateToJson(State instance) => <String, dynamic>{
      'value': _$NativePlayerStateEnumMap[instance.value],
      'viewId': instance.viewId,
    };

const _$NativePlayerStateEnumMap = {
  NativePlayerState.ready: 'ready',
  NativePlayerState.idle: 'idle',
  NativePlayerState.playing: 'playing',
  NativePlayerState.buffering: 'buffering',
  NativePlayerState.ended: 'ended',
  NativePlayerState.unknown: 'unknown',
};
