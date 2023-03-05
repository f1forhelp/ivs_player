part of 'package:ivs_player/ivs_player.dart';

enum PlayerState { playerViewLoaded, playerViewNotLoaded }

class IvsPlayerController extends ChangeNotifier {
  Completer<bool> _isPlayerViewLoaded = Completer<bool>();

  PlayerState _playerState = PlayerState.playerViewNotLoaded;

  PlayerState get playerState => _playerState;

  @protected
  set playerState(PlayerState v) {
    _playerState = v;
    notifyListeners();
  }

  //Ivs Native options

  // Indicates whether adaptive bitrate (ABR) streaming is allowed. Default: `true`.
  bool _autoQualityMode = true;

  /// Indicates whether the player loops the content when possible. Default: `false`.
  bool _looping = false;

  /// For a live stream, the latency from the server to the player. Note: For non-live streams, this value is not meaningful.
  Duration? _liveLatency;

  /// The audio-muting state of the player. Default: false.
  bool _muted = false;

  /// The video-playback rate. Supported range: 0.5 to 2.0. Default: 1.0 (normal).
  double _playbackRate = 1;

  /// Volume of the audio track, if any. Supported range: 0.0 to 1.0. Default: 1.0 (max).
  double _volume = 1;

  /// Current approximate bandwidth estimate in bits per second (bps).
  int? _bandwidthEstimate;

  /// Remaining duration of buffered content.
  Duration? _buffered;

  /// Total duration of the loaded media stream.
  Duration? _duration;

  /// Playback position.
  Duration? _position;

  /// Current quality being played, if any.
  ///
  /// This property returns nil before an initial quality has been determined.
  String? _quality;

  /// Quality objects from the loaded source or empty if none are currently available.
  /// The qualities will be available after the `IVSPlayerStateReady` state has been entered.
  /// This contains the qualities that can be assigned to `quality`.
  /// Note that this set will contain only qualities capable of being played on the current device
  /// and not all those present in the source stream.
  String? _qualities;

  /// The player's version, in the format of MAJOR.MINOR.PATCH-HASH.
  String? _version;

  /// Bitrate of the media stream.
  String? _videoBitrate;

  late final MethodChannel _methodChannel;

  Future<void> init() async {}

  Future<void> loadUrl({String? url}) async {
    if (!_isPlayerViewLoaded.isCompleted) {
      await _isPlayerViewLoaded.future;
    }
    _currentPlayingUrl = url ?? _currentPlayingUrl;
    _methodChannel.invokeMethod("load", url);
  }

  bool _isPlayerLoaded = false;

  bool get isPlayerLoaded => _isPlayerLoaded;

  @protected
  set isPlayerLoaded(bool v) {
    _isPlayerLoaded = v;
    notifyListeners();
  }

  String? _currentPlayingUrl;

  String? get currentPlayingUrl => _currentPlayingUrl;

  Future<void> play() async {
    await _methodChannel.invokeMethod(
      "play",
    );
  }

  Future<void> pause() async {}

  Future setAutoQualityMode(bool v) async {
    await _methodChannel.invokeMethod(
      "autoQualityMode-s",
      true,
    );
  }

  Future<bool> getAutoQualityMode() async {
    var res = await _methodChannel.invokeMethod(
      "autoQualityMode-g",
    );
    if (res is bool) {
      return res;
    }
    return false;
  }

  Future setLooping(bool v) async {
    await _methodChannel.invokeMethod(
      "looping-s",
      true,
    );
  }

  Future<bool> getLooping() async {
    var res = await _methodChannel.invokeMethod(
      "looping-g",
    );
    if (res is bool) {
      return res;
    }
    return false;
  }

  Future setMuted(bool v) async {
    await _methodChannel.invokeMethod(
      "muted-s",
      true,
    );
  }

  Future<bool> getMuted() async {
    var res = await _methodChannel.invokeMethod(
      "muted-g",
    );
    if (res is bool) {
      return res;
    }
    return false;
  }

  Future setPlaybackRate(bool v) async {
    await _methodChannel.invokeMethod(
      "playbackRate-s",
      true,
    );
  }

  Future<double> getPlaybackRate() async {
    var res = await _methodChannel.invokeMethod(
      "playbackRate-g",
    );
    if (res is double) {
      return res;
    }
    return 1;
  }

  Future setVolume(double v) async {
    await _methodChannel.invokeMethod(
      "playbackRate-s",
      true,
    );
  }

  Future<double> getVolume() async {
    var res = await _methodChannel.invokeMethod(
      "playbackRate-g",
    );
    if (res is double) {
      return res;
    }
    return 1;
  }

  Future startPip() async {
    await _methodChannel.invokeMethod(
      "enable_pip",
    );
  }

  @override
  void dispose() {
    print("");
    super.dispose();
  }
}
