part of 'ivs_player.dart';

// enum PlayerState { playerViewLoaded, playerViewNotLoaded }

class IvsPlayerController extends ChangeNotifier {
  // String _url = "";

  DurationListener durationListener =
      DurationListener(totalDuration: Duration.zero);

  bool _isPlayerInitialized = false;
  bool _isBuffering = true;
  bool _isMuted = false;
  bool _isPlaying = false;
  bool _isLooping = false;
  bool _isLiveStream = false;
  bool _isFullScreen = false;
  bool _isPictureInPictureSupported = false;
  bool get isPlayerInitialized => _isPlayerInitialized;
  Duration _totalDuration = const Duration(seconds: 0);

  IvsPlayerNativeEvent _ivsPlayerNativeEvent = IvsPlayerNativeEvent();

  IvsPlayerNativeEvent get ivsPlayerNativeEvent => _ivsPlayerNativeEvent;

  // ignore: prefer_final_fields
  int _viewId = 0;

  // ignore: prefer_final_fields
  Completer<bool> _isPlayerViewLoaded = Completer<bool>();

  bool get isPlaying => _isPlaying;
  bool get isMuted => _isMuted;
  Duration get totalDuration => _totalDuration;

  DateTime as = DateTime.now();

  Future<void> play() async {
    if (_ivsPlayerNativeEvent.playerState == NativePlayerState.ended) {
      durationListener.stop();
    }
    await IvsPlayerApi().play(
      ViewMessage(viewId: _viewId),
    );
    notifyListeners();
  }

  Future<void> pause() async {
    await IvsPlayerApi().pause(
      ViewMessage(viewId: _viewId),
    );
    notifyListeners();
  }

  Future<void> initialize() async {
    await _isPlayerViewLoaded.future;
    _isPlayerInitialized = true;
    PlayerEvents().getPlayerStateStream(
      (p0) {
        _ivsPlayerNativeEvent = p0;
        if (p0.duration != null && (p0.duration?.inMilliseconds ?? 0) > 1) {
          _totalDuration = p0.duration!;
          durationListener = DurationListener(totalDuration: _totalDuration);
        }

        switch (p0.playerState) {
          case NativePlayerState.playing:
            // if (!_isPlaying) {
            //   durationListener.stop();
            // }
            _isPlaying = true;
            durationListener.start();
            break;
          case NativePlayerState.buffering:
            durationListener.pause();
            break;
          case NativePlayerState.ended:
            _isPlaying = false;
            // durationListener.start();
            break;
          case NativePlayerState.idle:
            _isPlaying = false;
            durationListener.pause();
            break;
          case NativePlayerState.ready:
            _isPlaying = false;
            durationListener.pause();
            break;
          default:
          //Player State is unknown.
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
    // IvsPlayerApi().mute(MutedMessage(viewId: _viewId, muted: true));
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
    print("DUR-SEEK-${Duration(milliseconds: (seconds * 1000).round())}");
    durationListener.seekTo(
        durationToSeek: Duration(milliseconds: (seconds * 1000).round()));
    await IvsPlayerApi().seekTo(SeekMessage(viewId: _viewId, seconds: seconds));
  }

  @override
  void dispose() async {
    durationListener.dispose();
    await IvsPlayerApi().dispose(ViewMessage(viewId: _viewId));
    super.dispose();
  }
}
