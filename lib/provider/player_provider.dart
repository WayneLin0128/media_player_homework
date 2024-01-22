import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playingProvider =
    StateNotifierProvider<PlayingNotifier, bool>((ref) => PlayingNotifier());

class PlayingNotifier extends StateNotifier<bool> {
  PlayingNotifier() : super(false);

  playOrPause(Player player) {
    state = !state;
  }

  stop(Player player) {
    state = false;
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, double>(
    (ref) => PositionNotifier());

class PositionNotifier extends StateNotifier<double> {
  PositionNotifier() : super(0.0);

  setProgress(double value) {
    state = value.toDouble();
  }

  changeSeekbar(double value) {
    state = value.toDouble();
    debugPrint('seconds: ${value ~/ 1000}');
    debugPrint('milliseconds: ${(value % 1000).toInt()}');
  }
}
