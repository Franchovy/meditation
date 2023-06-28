import 'package:flutter/material.dart';

import 'package:meditation/components/sound_player.dart';
import 'package:meditation/models/sounds.dart';
import 'package:meditation/models/timer.dart';

class Home extends StatefulWidget {
  Home({this.timerLength = 3, super.key});

  final int timerLength;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SoundPlayer _player;
  late AppTimer _timer;

  @override
  void initState() {
    super.initState();

    _player = SoundPlayer();
    _timer = AppTimer(lengthInSeconds: widget.timerLength);
    _timer.onEnded = _onTimerEnded;
  }

  void _startTimer() {
    setState(() {
      _timer.start();
    });
  }

  void _resetTimer() {
    setState(() {
      _timer.reset();
    });
  }

  void _onTimerEnded() {
    _player.playSound(Sounds.meditationEnd);

    setState(() {
      _timer.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Meditation')),
      ),
      body: timerWidget(context),
    );
  }

  Widget timerWidget(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: _timer,
        builder: (context, value, child) => Center(
              child: GestureDetector(
                onTap: _timer.isActive ? _resetTimer : _startTimer,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                          value: _timer.progress,
                          backgroundColor: Colors.grey.shade200,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      _timer.displayText,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
