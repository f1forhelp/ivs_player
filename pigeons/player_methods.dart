import 'package:pigeon/pigeon_lib.dart';

@HostApi()
abstract class PlayerMethod {
  Future<void> play();
}
