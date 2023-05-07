// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pigeon/pigeon.dart';

//Run this commnad for changes to be visible "flutter pub run pigeon --input pigeons/messages.dart"
@ConfigurePigeon(PigeonOptions(
  dartOut: "lib/src/player_api.dart",
  swiftOptions: SwiftOptions(),
  swiftOut: "ios/Classes/Pigeon.swift",
))
@HostApi()
abstract class IvsPlayerApi {
  bool autoQualityMode(AutoQualityModeMessage mode);
  bool looping(LoopingMessage loopingMessage);
  bool mute(MutedMessage mutedMessage);
  double playbackRate(PlaybackRateMessage playbackRateMessage);
  double volume(VolumeMessage volumeMessage);
  double videoDuration(ViewMessage viewMessage);
  double playbackPosition(ViewMessage viewMessage);
  List<FQuality> qualities(ViewMessage viewMessage);
  FQuality quality(FQualityMessage qualityMessage);

  void pause(ViewMessage viewMessage);
  void load(LoadMessage loadMessage);
  void play(ViewMessage viewMessage);
  void seekTo(SeekMessage seekMessage);
  void dispose(ViewMessage viewMessage);
}

class ViewMessage {
  int viewId;
  ViewMessage({
    required this.viewId,
  });
}

class LoadMessage {
  int viewId;
  String url;
  LoadMessage({
    required this.viewId,
    required this.url,
  });
}

class AutoQualityModeMessage {
  int viewId;
  bool? autoQualityMode;
  AutoQualityModeMessage({
    required this.viewId,
    this.autoQualityMode,
  });
}

class LoopingMessage {
  int viewId;
  bool? looping;
  LoopingMessage({
    required this.viewId,
    this.looping,
  });
}

class MutedMessage {
  int viewId;
  bool? muted;
  MutedMessage({
    required this.viewId,
    this.muted,
  });
}

class FQualityMessage {
  int viewId;
  FQuality? quality;
  FQualityMessage({
    required this.viewId,
    this.quality,
  });
}

class PlaybackRateMessage {
  int viewId;
  double? playbackRate;
  PlaybackRateMessage({
    required this.viewId,
    this.playbackRate,
  });
}

class SeekMessage {
  int viewId;
  double seconds;
  SeekMessage({
    required this.viewId,
    required this.seconds,
  });
}

class VolumeMessage {
  int viewId;
  double? volume;
  VolumeMessage({
    required this.viewId,
    this.volume,
  });
}

class FQuality {
  String name;
  int height;
  int width;
  FQuality({
    required this.name,
    required this.height,
    required this.width,
  });
}
