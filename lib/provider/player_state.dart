import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:async';

import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerStateProvider =
    ChangeNotifierProvider((ref) => PlayerStateNotifier());

class PlayerStateNotifier extends ChangeNotifier {
  double seekbarValue = 0, volumeValue = 0.5, totalDuration = 0;
  bool isPlaying = true;
  Player player = Player();
  List<StreamSubscription> subscriptions = [];
  late bool playing = player.state.playing;
  late Duration position = player.state.position;
  late Duration duration = player.state.duration;
  late Duration buffer = player.state.buffer;
  bool seeking = false;

  init() {
    player.open(Media('assets/ForBiggerFun.mp4')).then((value) {
      playing = player.state.playing;
      position = player.state.position;
      duration = player.state.duration;
      buffer = player.state.buffer;
      // onProgress();
    });
  }

  onProgress() {
    try {
      player.stream.playing.listen((event) {
        playing = event;
        notifyListeners();
      });
      player.stream.duration.listen((event) {
        totalDuration = event.inMilliseconds.toDouble();
        duration = event;
        // onVolumeChange(volumeValue);
        // print(totalDuration);
        notifyListeners();
      });
      player.stream.position.listen((event) {
        if (!seeking) position = event;
        double val = event.inMilliseconds.toDouble() / totalDuration;
        if (val > 0 && val < 1) {
          seekbarValue = val;
        }
        notifyListeners();
      });
      player.stream.completed.listen((event) {
        position = Duration.zero;
        seekbarValue = 0;
        player.stop();
        isPlaying = false;
        notifyListeners();
      });
      player.stream.buffer.listen((event) {
        buffer = event;
      });
    } catch (e) {
      log('No Error in onProgress');
    }
  }

  VideoController show() {
    return VideoController(player);
  }

  Player getPlayer() {
    return player;
  }

  onPlay() {
    try {
      if (isPlaying) {
        player.pause();
        isPlaying = false;
      } else {
        player.play();
        isPlaying = true;
      }
      notifyListeners();
    } catch (e) {
      log('No Error in onPlay');
    }
  }

  onStop() {
    player.pause();
    player.seek(
      const Duration(
        minutes: 0,
        seconds: 0,
      ),
    );
    isPlaying = false;
    notifyListeners();
  }

  changeSeekbar(double value) {
    seekbarValue = value;
    player.seek(Duration(milliseconds: (value * totalDuration).toInt()));
    notifyListeners();
  }
}
