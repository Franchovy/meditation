import 'dart:async';

import 'package:flutter/foundation.dart';

class AppTimerState {
  AppTimerState({required this.remainingTime, required this.isActive});

  int remainingTime;
  bool isActive;
}

class AppTimer extends ValueNotifier<int> {
  AppTimer({required this.lengthInSeconds, this.isActive = false})
      : super(lengthInSeconds) {
    _remainingTime = lengthInSeconds;
  }

  void Function()? onEnded;

  int lengthInSeconds;
  bool isActive;

  late int _remainingTime;
  Timer? _timer;

  int get remainingTime => _remainingTime;

  void start() {
    if (_timer != null && _timer!.isActive) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;

        notifyListeners();
      } else {
        onEnded?.call();

        reset();
      }
    });

    isActive = true;
    _remainingTime = lengthInSeconds;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();

    isActive = false;
    _remainingTime = lengthInSeconds;

    notifyListeners();
  }

  String get displayText =>
      '${(_remainingTime / 60).floor()}:${(_remainingTime % 60).toString().padLeft(2, '0')}';

  double get progress => isActive ? value / lengthInSeconds : 1.0;
}
