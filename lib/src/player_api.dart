// Autogenerated from Pigeon (v9.0.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class ViewMessage {
  ViewMessage({
    required this.viewId,
  });

  int viewId;

  Object encode() {
    return <Object?>[
      viewId,
    ];
  }

  static ViewMessage decode(Object result) {
    result as List<Object?>;
    return ViewMessage(
      viewId: result[0]! as int,
    );
  }
}

class LoadMessage {
  LoadMessage({
    required this.viewId,
    required this.url,
  });

  int viewId;

  String url;

  Object encode() {
    return <Object?>[
      viewId,
      url,
    ];
  }

  static LoadMessage decode(Object result) {
    result as List<Object?>;
    return LoadMessage(
      viewId: result[0]! as int,
      url: result[1]! as String,
    );
  }
}

class AutoQualityModeMessage {
  AutoQualityModeMessage({
    required this.viewId,
    this.autoQualityMode,
  });

  int viewId;

  bool? autoQualityMode;

  Object encode() {
    return <Object?>[
      viewId,
      autoQualityMode,
    ];
  }

  static AutoQualityModeMessage decode(Object result) {
    result as List<Object?>;
    return AutoQualityModeMessage(
      viewId: result[0]! as int,
      autoQualityMode: result[1] as bool?,
    );
  }
}

class LoopingMessage {
  LoopingMessage({
    required this.viewId,
    this.looping,
  });

  int viewId;

  bool? looping;

  Object encode() {
    return <Object?>[
      viewId,
      looping,
    ];
  }

  static LoopingMessage decode(Object result) {
    result as List<Object?>;
    return LoopingMessage(
      viewId: result[0]! as int,
      looping: result[1] as bool?,
    );
  }
}

class MutedMessage {
  MutedMessage({
    required this.viewId,
    this.muted,
  });

  int viewId;

  bool? muted;

  Object encode() {
    return <Object?>[
      viewId,
      muted,
    ];
  }

  static MutedMessage decode(Object result) {
    result as List<Object?>;
    return MutedMessage(
      viewId: result[0]! as int,
      muted: result[1] as bool?,
    );
  }
}

class PlaybackRateMessage {
  PlaybackRateMessage({
    required this.viewId,
    this.playbackRate,
  });

  int viewId;

  double? playbackRate;

  Object encode() {
    return <Object?>[
      viewId,
      playbackRate,
    ];
  }

  static PlaybackRateMessage decode(Object result) {
    result as List<Object?>;
    return PlaybackRateMessage(
      viewId: result[0]! as int,
      playbackRate: result[1] as double?,
    );
  }
}

class SeekMessage {
  SeekMessage({
    required this.viewId,
    required this.seconds,
  });

  int viewId;

  double seconds;

  Object encode() {
    return <Object?>[
      viewId,
      seconds,
    ];
  }

  static SeekMessage decode(Object result) {
    result as List<Object?>;
    return SeekMessage(
      viewId: result[0]! as int,
      seconds: result[1]! as double,
    );
  }
}

class VolumeMessage {
  VolumeMessage({
    required this.viewId,
    this.volume,
  });

  int viewId;

  double? volume;

  Object encode() {
    return <Object?>[
      viewId,
      volume,
    ];
  }

  static VolumeMessage decode(Object result) {
    result as List<Object?>;
    return VolumeMessage(
      viewId: result[0]! as int,
      volume: result[1] as double?,
    );
  }
}

class _IvsPlayerApiCodec extends StandardMessageCodec {
  const _IvsPlayerApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AutoQualityModeMessage) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is LoadMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is LoopingMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is MutedMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is PlaybackRateMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is SeekMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is ViewMessage) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is VolumeMessage) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return AutoQualityModeMessage.decode(readValue(buffer)!);
      case 129: 
        return LoadMessage.decode(readValue(buffer)!);
      case 130: 
        return LoopingMessage.decode(readValue(buffer)!);
      case 131: 
        return MutedMessage.decode(readValue(buffer)!);
      case 132: 
        return PlaybackRateMessage.decode(readValue(buffer)!);
      case 133: 
        return SeekMessage.decode(readValue(buffer)!);
      case 134: 
        return ViewMessage.decode(readValue(buffer)!);
      case 135: 
        return VolumeMessage.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class IvsPlayerApi {
  /// Constructor for [IvsPlayerApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  IvsPlayerApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _IvsPlayerApiCodec();

  Future<bool> autoQualityMode(AutoQualityModeMessage arg_mode) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.autoQualityMode', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mode]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<bool> looping(LoopingMessage arg_loopingMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.looping', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_loopingMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<bool> mute(MutedMessage arg_mutedMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.mute', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mutedMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<double> playbackRate(PlaybackRateMessage arg_playbackRateMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.playbackRate', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playbackRateMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as double?)!;
    }
  }

  Future<double> volume(VolumeMessage arg_volumeMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.volume', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_volumeMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as double?)!;
    }
  }

  Future<double> videoDuration(ViewMessage arg_viewMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.videoDuration', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_viewMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as double?)!;
    }
  }

  Future<double> playbackPosition(ViewMessage arg_viewMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.playbackPosition', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_viewMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as double?)!;
    }
  }

  Future<void> pause(ViewMessage arg_viewMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.pause', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_viewMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> load(LoadMessage arg_loadMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.load', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_loadMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> play(ViewMessage arg_viewMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.play', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_viewMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> seekTo(SeekMessage arg_seekMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.seekTo', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_seekMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> dispose(ViewMessage arg_viewMessage) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.IvsPlayerApi.dispose', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_viewMessage]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}
