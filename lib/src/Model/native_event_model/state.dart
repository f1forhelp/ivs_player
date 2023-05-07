import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

enum NativePlayerState { ready, idle, playing, buffering, ended, unknown }

@JsonSerializable()
class State {
  @JsonKey(fromJson: _mapPlayerStateEnum)
  NativePlayerState? value;
  int? viewId;

  State({this.value, this.viewId});

  @override
  String toString() => 'State(value: $value, viewId: $viewId)';

  factory State.fromJson(Map<String, dynamic> json) => _$StateFromJson(json);

  Map<String, dynamic> toJson() => _$StateToJson(this);
}

NativePlayerState _mapPlayerStateEnum(v) {
  switch (int.tryParse(v.toString())) {
    case 1:
      return NativePlayerState.ready;
    case 2:
      return NativePlayerState.idle;
    case 3:
      return NativePlayerState.playing;
    case 4:
      return NativePlayerState.buffering;
    case 5:
      return NativePlayerState.ended;
    default:
      return NativePlayerState.unknown;
  }
}
