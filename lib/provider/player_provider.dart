import 'dart:math';
import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/foundation.dart';

// final playing = StateProvider<bool>((ref) {
//   return false;
// });

final playerProvider =
    StateNotifierProvider<PlayerNotifier, Player>((ref) => PlayerNotifier());

class PlayerNotifier extends StateNotifier<Player> {
  PlayerNotifier() : super(Player());

  // late bool playing = false;
  // Player player = Player();
  late Duration position = state.state.position;
  late Duration duration = state.state.duration;

  bool playing = false;
  bool seeking = false;

  void loadVideo(String s) {
    state.open(
      Media(s),
      play: false,
    );
    state.setVolume(70);
  }

  onPlay() {
    if (playing) {
      state.pause();
      playing = false;
    } else {
      state.play();
      playing = true;
    }
    debugPrint("Press Play or pause, playing state: $playing");
  }

  onProgress() {
    try {
      state.stream.playing.listen((event) {
        playing = event;
        // debugPrint('playing event: $playing');
      });
      state.stream.duration.listen((event) {
        duration = event;
        // debugPrint('duration: $duration');
      });
      state.stream.position.listen((event) {
        // if (!seeking) position = event;
      });
    } catch (e) {
      debugPrint('error');
    }
  }

  onStop() {
    state.pause();
    state.seek(const Duration(minutes: 0, seconds: 0));
    playing = false;
    debugPrint("Press Stop, playing state: $playing");
  }

  Icon changeIcon() {
    debugPrint('Set Icon $playing');
    return Icon(
      playing ? Icons.pause : Icons.play_arrow,
    );
  }
}
