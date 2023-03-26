part of 'ivs_player.dart';

enum PlayerState { playerViewLoaded, playerViewNotLoaded }

class IvsPlayerController extends ChangeNotifier {
  // String _url = "";

  bool _isPlayerLoaded = false;

  bool get isPlayerLoaded => _isPlayerLoaded;

  // ignore: prefer_final_fields
  int _viewId = 0;

  // ignore: prefer_final_fields
  Completer<bool> _isPlayerViewLoaded = Completer<bool>();

  Future<void> play() async {
    await IvsPlayerApi().play(
      ViewMessage(viewId: _viewId),
    );
    await IvsPlayerApi().muted(MutedMessage(viewId: _viewId, muted: true));
  }

  Future<void> pause() async {
    await IvsPlayerApi().pause(
      ViewMessage(viewId: _viewId),
    );
  }

  Future<void> load({required String url}) async {
    await _isPlayerViewLoaded.future;
    await IvsPlayerApi().load(
      LoadMessage(viewId: _viewId, url: url),
    );
    _isPlayerLoaded = true;
    PlayerEvents()
        .playerState
        .receiveBroadcastStream()
        .asBroadcastStream()
        .listen((event) {
      print("EVENT IS:" + event.toString());
    });
    notifyListeners();
  }

  Future<bool> autoQualityMode({bool? v}) async {
    return await IvsPlayerApi().autoQualityMode(
      AutoQualityModeMessage(viewId: _viewId, autoQualityMode: v),
    );
  }

  Future<bool> looping({bool? v}) async {
    return await IvsPlayerApi().looping(
      LoopingMessage(viewId: _viewId, looping: v),
    );
  }

  Future<bool> muted({bool? v}) async {
    return await IvsPlayerApi().muted(
      MutedMessage(viewId: _viewId, muted: v),
    );
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
    return await IvsPlayerApi()
        .seekTo(SeekMessage(viewId: _viewId, seconds: seconds));
  }

  @override
  void dispose() async {
    await IvsPlayerApi().dispose(ViewMessage(viewId: _viewId));
    super.dispose();
  }
}
