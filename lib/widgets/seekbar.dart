import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_player_homework/provider/player_provider.dart';

class SeekBar extends ConsumerStatefulWidget {
  const SeekBar({super.key});

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends ConsumerState<SeekBar> {
  late Duration position = ref.read(playerProvider).state.position;
  late Duration duration = ref.read(playerProvider).state.duration;

  bool seeking = false;

  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
    position = ref.read(playerProvider).state.position;
    duration = ref.read(playerProvider).state.duration;
    subscriptions.addAll(
      [
        ref.read(playerProvider).stream.position.listen((event) {
          setState(() {
            if (!seeking) position = event;
            // debugPrint('position: $position');
          });
        }),
        ref.read(playerProvider).stream.duration.listen((event) {
          setState(() {
            duration = event;
            // debugPrint('duration: $duration');
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
    return Expanded(
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
          ref.read(playerProvider).seek(Duration(milliseconds: e ~/ 1));
        },
      ),
    );
  }
}
