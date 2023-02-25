import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ivs_player/ivs_player_method_channel.dart';

void main() {
  MethodChannelIvsPlayer platform = MethodChannelIvsPlayer();
  const MethodChannel channel = MethodChannel('ivs_player');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
