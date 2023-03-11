import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ivs_player_method_channel.dart';

abstract class IvsPlayerPlatform extends PlatformInterface {
  /// Constructs a IvsPlayerPlatform.
  IvsPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static IvsPlayerPlatform _instance = MethodChannelIvsPlayer();

  /// The default instance of [IvsPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelIvsPlayer].
  static IvsPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IvsPlayerPlatform] when
  /// they register themselves.
  static set instance(IvsPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
