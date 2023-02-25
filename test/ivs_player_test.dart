import 'package:flutter_test/flutter_test.dart';
import 'package:ivs_player/ivs_player.dart';
import 'package:ivs_player/ivs_player_platform_interface.dart';
import 'package:ivs_player/ivs_player_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIvsPlayerPlatform
    with MockPlatformInterfaceMixin
    implements IvsPlayerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IvsPlayerPlatform initialPlatform = IvsPlayerPlatform.instance;

  test('$MethodChannelIvsPlayer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIvsPlayer>());
  });

  test('getPlatformVersion', () async {
    IvsPlayer ivsPlayerPlugin = IvsPlayer();
    MockIvsPlayerPlatform fakePlatform = MockIvsPlayerPlatform();
    IvsPlayerPlatform.instance = fakePlatform;

    expect(await ivsPlayerPlugin.getPlatformVersion(), '42');
  });
}
