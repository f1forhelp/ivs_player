part of 'ivs_player.dart';

class DurationListener extends ChangeNotifier {
  Timer? _timer;

  Duration _lastDuration = const Duration();

  Duration _currentDuration = const Duration();

  Duration _totalDuration = const Duration();

  double _currentDurationInPercentage = 0;

  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  double get currentDurationInPercentage => _currentDurationInPercentage;

  DurationListener({required Duration totalDuration}) {
    _totalDuration = totalDuration;
  }

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      if (timer.isActive && _currentDuration <= _totalDuration) {
        _currentDuration =
            Duration(milliseconds: 10 * timer.tick) + _lastDuration;
      } else {
        _timer?.cancel();
      }
      _currentDurationInPercentage =
          _currentDuration.inMilliseconds / (_totalDuration.inMilliseconds);
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

  void seekTo({Duration? durationToSeek, double? percentageToSeek}) {
    assert(!(durationToSeek == null && percentageToSeek == null));
    if (durationToSeek != null) {
      // _currentDuration = durationToSeek;
      _lastDuration = durationToSeek;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
