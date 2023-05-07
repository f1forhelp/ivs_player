import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ivs_player_platform_interface.dart';

/// An implementation of [IvsPlayerPlatform] that uses method channels.
class MethodChannelIvsPlayer extends IvsPlayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ivs_player');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
