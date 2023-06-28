import 'package:flutter/material.dart';
import 'dart:async';

import 'package:meditation/components/sound_player.dart';
import 'package:meditation/models/sounds.dart';

class Home extends StatefulWidget {
  Home({this.timerLength = 600, super.key});

  final int timerLength;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player = SoundPlayer();
  bool _isTimerActive = false;
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _remainingTime = widget.timerLength;
  }

  void _startTimer() {
    setState(() {
      _isTimerActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        player.playSound(Sounds.meditationEndDefault);
        _resetTimer();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _isTimerActive = false;
      _remainingTime = widget.timerLength;
    });

    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Meditation')),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _isTimerActive ? _resetTimer : _startTimer,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                    value: _isTimerActive
                        ? _remainingTime / widget.timerLength
                        : 1.0,
                    backgroundColor: Colors.grey.shade200,
                    color: const Color.fromARGB(255, 0, 195, 239)),
              ),
              Text(
                '${(_remainingTime / 60).floor()}:${(_remainingTime % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
