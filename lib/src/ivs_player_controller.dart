part of 'ivs_player.dart';

// enum PlayerState { playerViewLoaded, playerViewNotLoaded }

class IvsPlayerController extends ChangeNotifier {
  // String _url = "";

  DurationListener durationListener = DurationListener();

  bool _isPlayerInitialized = false;
  bool _isBuffering = true;
  bool _isMuted = false;
  bool _isPlaying = false;
  bool _isLooping = false;
  bool _isLiveStream = false;
  bool _isFullScreen = false;
  bool _isPictureInPictureSupported = false;
  Quality _currentAuality = Quality();
  bool get isPlayerInitialized => _isPlayerInitialized;
  Quality get currentQuality => _currentAuality;
  Duration _totalDuration = const Duration(seconds: 0);

  NativeEventModel _ivsPlayerNativeEvent = NativeEventModel();

  NativeEventModel get ivsPlayerNativeEvent => _ivsPlayerNativeEvent;

  // ignore: prefer_final_fields
  int _viewId = 0;

  // ignore: prefer_final_fields
  Completer<bool> _isPlayerViewLoaded = Completer<bool>();

  bool get isPlaying => _isPlaying;
  bool get isMuted => _isMuted;
  Duration get totalDuration => _totalDuration;

  DateTime as = DateTime.now();

  Future<void> play() async {
    if (_ivsPlayerNativeEvent.state?.value == NativePlayerState.ended) {
      durationListener.stop();
    }
    await IvsPlayerApi().play(
      ViewMessage(viewId: _viewId),
    );
  }

  Future<void> pause() async {
    await IvsPlayerApi().pause(
      ViewMessage(viewId: _viewId),
    );
  }

  Future<void> initialize() async {
    var res = await IvsPlayerApi().create();
    _viewId = res ?? 0;
    // await _isPlayerViewLoaded.future;
    _isPlayerInitialized = true;
    PlayerEvents().getPlayerStateStream((p0) {
      _ivsPlayerNativeEvent = p0;
      if (p0.duration?.value != null &&
          (p0.duration?.value?.inMilliseconds ?? 0) > 1) {
        _totalDuration = (p0.duration?.value)!;
        durationListener.totalDuration = _totalDuration;
      }

      if (_currentAuality.name != p0.quality?.name &&
          p0.quality?.name != null) {
        _currentAuality = p0.quality ?? Quality();
      }

      switch (p0.state?.value) {
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
          // pause();
          break;
        default:
        //Player State is unknown.
      }
      notifyListeners();
    }, _viewId);
    notifyListeners();
  }

  Future<void> load({required String url}) async {
    await IvsPlayerApi().load(
      LoadMessage(viewId: _viewId, url: url),
    );
    // await pause();
    // IvsPlayerApi().mute(MutedMessage(viewId: _viewId, muted: true));
    // notifyListeners();
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
    var rate = await IvsPlayerApi().playbackRate(
      PlaybackRateMessage(viewId: _viewId, playbackRate: v),
    );
    durationListener.playBackRate(v ?? 1);
    return rate;
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

  Future<List<FQuality?>> qualities() async {
    var q = await IvsPlayerApi().qualities(ViewMessage(viewId: _viewId));
    return q;
  }

  Future setQuality(String name) async {
    await IvsPlayerApi().quality(FQualityMessage(
        viewId: _viewId, quality: FQuality(name: name, height: 0, width: 0)));
  }

  Future<void> seekTo(double seconds) async {
    // if (_isPlaying) {
    //   seekController.forward();
    // }

    var duratInMili = (seconds * 1000).round();

    if (duratInMili >= _totalDuration.inMilliseconds) {
      _isPlaying = false;
      notifyListeners();
    }

    durationListener.seekTo(
        durationToSeek: Duration(milliseconds: duratInMili));
    try {
      await IvsPlayerApi().seekTo(
        SeekMessage(
          viewId: _viewId,
          seconds: duratInMili > _totalDuration.inMilliseconds
              ? (_totalDuration.inMilliseconds / 1000)
              : seconds,
        ),
      );
    } catch (e) {
      print("DURAT--3--$e");
    }
  }

  @override
  void dispose() async {
    await IvsPlayerApi().dispose(ViewMessage(viewId: _viewId));
    durationListener.dispose();
    super.dispose();
  }
}
