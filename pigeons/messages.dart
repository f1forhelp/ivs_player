import 'package:pigeon/pigeon.dart';

//Run this commnad for changes to be visible "flutter pub run pigeon --input pigeons/messages.dart"
@ConfigurePigeon(PigeonOptions(
  dartOut: "lib/player_method.dart",
  swiftOptions: SwiftOptions(),
  swiftOut: "ios/Classes/Pigeon.swift",
))
@HostApi()
abstract class IvsPlayerApi {
  void pause();
  void load(String url);
  void play();
}
