import 'package:json_annotation/json_annotation.dart';

import "nduration.dart";
import 'error.dart';
import 'quality.dart';
import 'state.dart';

part 'native_event_model.g.dart';

@JsonSerializable()
class NativeEventModel {
  State? state;
  NDuration? duration;
  Error? error;
  Quality? quality;

  NativeEventModel({this.state, this.duration, this.error, this.quality});

  @override
  String toString() {
    return 'NativeEventModel(state: $state, duration: $duration, error: $error, quality: $quality)';
  }

  factory NativeEventModel.fromJson(Map<String, dynamic> json) {
    return _$NativeEventModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NativeEventModelToJson(this);
}


// {
//     "state": {
//         "value": 1,
//         "viewId": ""
//     },
//     "duration": {
//         "value": 0.2,
//         "viewId": ""
//     },
//     "error": {
//         "value": "",
//         "viewId": ""
//     },
//     "quality": {
//         "width": 0,
//         "height": 0,
//         "name": ""
//     }
// }