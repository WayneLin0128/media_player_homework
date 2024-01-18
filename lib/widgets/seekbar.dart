import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

class SeekBar extends StatefulWidget {
  final Player player;
  const SeekBar({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  late bool playing = widget.player.state.playing;
  late Duration position = widget.player.state.position;
  late Duration duration = widget.player.state.duration;
  late Duration buffer = widget.player.state.buffer;

  bool seeking = false;

  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
    playing = widget.player.state.playing;
    position = widget.player.state.position;
    duration = widget.player.state.duration;
    buffer = widget.player.state.buffer;
    subscriptions.addAll(
      [
        widget.player.stream.playing.listen((event) {
          setState(() {
            playing = event;
          });
        }),
        widget.player.stream.completed.listen((event) {
          setState(() {
            position = Duration.zero;
          });
        }),
        widget.player.stream.position.listen((event) {
          setState(() {
            if (!seeking) position = event;
          });
        }),
        widget.player.stream.duration.listen((event) {
          setState(() {
            duration = event;
          });
        }),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final s in subscriptions) {
      s.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: widget.player.playOrPause,
                icon: Icon(
                  playing ? Icons.pause : Icons.play_arrow,
                ),
                color: Theme.of(context).primaryColor,
                iconSize: 36.0,
              ),
              IconButton(
                onPressed: () {
                  // widget.player.stop();
                  widget.player.pause();
                  widget.player.seek(
                    const Duration(
                      minutes: 0,
                      seconds: 0,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.stop,
                ),
                color: Theme.of(context).primaryColor,
                iconSize: 36.0,
              ),
              Expanded(
                child: Slider(
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble(),
                  value: position.inMilliseconds.toDouble().clamp(
                        0.0,
                        duration.inMilliseconds.toDouble(),
                      ),
                  onChangeStart: (e) {
                    seeking = true;
                  },
                  onChanged: position.inMilliseconds > 0
                      ? (e) {
                          setState(() {
                            position = Duration(milliseconds: e ~/ 1);
                          });
                        }
                      : null,
                  onChangeEnd: (e) {
                    seeking = false;
                    widget.player.seek(Duration(milliseconds: e ~/ 1));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
