part of 'ivs_player.dart';

// enum PlayerState { playerViewLoaded, playerViewNotLoaded }

class IvsPlayerController extends ChangeNotifier implements TickerProvider {
  // String _url = "";

  Duration _lastDuration = Duration(seconds: 0);

  bool _isPlayerInitialized = false;
  bool _isBuffering = true;
  bool _isMuted = false;
  bool _isPlaying = false;
  bool _isLooping = false;
  bool _isLiveStream = false;
  bool _isFullScreen = false;
  bool _isPictureInPictureSupported = false;
  bool get isPlayerInitialized => _isPlayerInitialized;
  Duration _totalDuration = Duration(seconds: 0);

  Duration getCurrentDuration() {
    var totalMilliSeconds = _totalDuration.inMilliseconds;

    var p = (totalMilliSeconds) * seekController.value;
    return Duration(milliseconds: p.round());
  }

  // ignore: prefer_final_fields
  int _viewId = 0;

  late AnimationController seekController;

  IvsPlayerController() {
    seekController = AnimationController(vsync: this);
  }

  // ignore: prefer_final_fields
  Completer<bool> _isPlayerViewLoaded = Completer<bool>();

  bool get isPlaying => _isPlaying;
  bool get isMuted => _isMuted;
  Duration get totalDuration => _totalDuration;

  Future<void> play() async {
    _isPlaying = true;
    notifyListeners();
    await IvsPlayerApi().play(
      ViewMessage(viewId: _viewId),
    );
  }

  Future<void> pause() async {
    _isPlaying = false;
    notifyListeners();

    await IvsPlayerApi().pause(
      ViewMessage(viewId: _viewId),
    );
  }

  Future<void> initialize() async {
    await _isPlayerViewLoaded.future;
    _isPlayerInitialized = true;
    PlayerEvents().getPlayerStateStream(
      (p0) {
        if (p0.duration != null && (p0.duration?.inMilliseconds ?? 0) > 1) {
          _totalDuration = p0.duration!;
          seekController.duration = _totalDuration;
          // seekController.duration = Duration(seconds: 20);
        }
        print(p0.playerState);
        if (p0.playerState == PlayerState.ended) {
          _isPlaying = false;
        }
        if (p0.playerState == PlayerState.playing) {
          seekController.forward();
        } else {
          _isPlaying = false;
          print(seekController.value);
          seekController.stop(canceled: false);
        }
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> load({required String url}) async {
    await IvsPlayerApi().load(
      LoadMessage(viewId: _viewId, url: url),
    );
    IvsPlayerApi().mute(MutedMessage(viewId: _viewId, muted: true));
    notifyListeners();
  }

  Future<bool> autoQualityMode({bool? v}) async {
    return await IvsPlayerApi().autoQualityMode(
      AutoQualityModeMessage(viewId: _viewId, autoQualityMode: v),
    );
  }

  Future<bool> looping({bool? v}) async {
    var res = await IvsPlayerApi().looping(
      LoopingMessage(viewId: _viewId, looping: v),
    );
    _isLooping = res;
    notifyListeners();
    return _isLooping;
  }

  Future<bool> mute({bool? v}) async {
    var res = await IvsPlayerApi().mute(
      MutedMessage(viewId: _viewId, muted: v),
    );
    _isMuted = res;
    notifyListeners();
    return _isMuted;
  }

  Future<double> playbackRate({double? v}) async {
    return await IvsPlayerApi().playbackRate(
      PlaybackRateMessage(viewId: _viewId, playbackRate: v),
    );
  }

  Future<double> volume({double? v}) async {
    return await IvsPlayerApi().volume(
      VolumeMessage(viewId: _viewId, volume: v),
    );
  }

  Future<double> playbackPosition() async {
    return await IvsPlayerApi().playbackPosition(ViewMessage(viewId: _viewId));
  }

  Future<double> videoDuration() async {
    return await IvsPlayerApi().videoDuration(ViewMessage(viewId: _viewId));
  }

  Future<void> seekTo(double seconds) async {
    // if (_isPlaying) {
    //   seekController.forward();
    // }

    await IvsPlayerApi().seekTo(SeekMessage(viewId: _viewId, seconds: seconds));
  }

  @override
  void dispose() async {
    await IvsPlayerApi().dispose(ViewMessage(viewId: _viewId));
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    print(onTick);
    return Ticker(onTick);
  }
}
