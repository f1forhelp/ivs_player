
import 'ivs_player_platform_interface.dart';

class IvsPlayer {
  Future<String?> getPlatformVersion() {
    return IvsPlayerPlatform.instance.getPlatformVersion();
  }
}
