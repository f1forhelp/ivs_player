part of 'package:ivs_player/src/player/ivs_player.dart';

class DurationListener extends ChangeNotifier {
  Timer? _timer;

  Duration _lastDuration = const Duration();

  Duration _currentDuration = const Duration();

  Duration _totalDuration = const Duration();

  double _playBackRate = 1;
  // double _currentDurationInPercentage = 0;

  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  double get currentDurationInPercentage => _totalDuration.inMilliseconds > 0
      ? (_currentDuration.inMilliseconds / (_totalDuration.inMilliseconds))
      : 0;

  set totalDuration(Duration totalDuration) {
    _totalDuration = totalDuration;
    notifyListeners();
  }

  void start() {
    _timer = Timer.periodic(Duration(microseconds: (1000).truncate()), (timer) {
      if (timer.isActive && _currentDuration < _totalDuration) {
        _currentDuration = Duration(
                microseconds: (1000 * timer.tick * _playBackRate).truncate()) +
            _lastDuration;
      } else {
        _timer?.cancel();
      }
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
    _currentDuration = Duration.zero;
    _lastDuration = Duration.zero;
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    _lastDuration = currentDuration;
    notifyListeners();
  }

  void playBackRate(double rate) {
    _playBackRate = rate;
    pause();
    start();
    notifyListeners();
  }

  void seekTo({Duration? durationToSeek, double? percentageToSeek}) async {
    assert(!(durationToSeek == null && percentageToSeek == null));

    bool isPlayingAlready = _timer?.isActive ?? false;

    if (durationToSeek != null) {
      _lastDuration =
          durationToSeek > _totalDuration ? _totalDuration : durationToSeek;
      _currentDuration = _lastDuration;
      _timer?.cancel();

      if (isPlayingAlready) {
        start();
      }

      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
