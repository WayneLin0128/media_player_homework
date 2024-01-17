import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

import 'package:media_player_homework/widgets/seekbar.dart';
import 'package:media_player_homework/provider/player_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerRef = ref.read(playerStateProvider);
    playerRef.init();
    Player player = playerRef.getPlayer();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Media player',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.topLeft,
                child: Video(
                  controller: VideoController(player),
                  controls: NoVideoControls,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SeekBar(),
            ),
          ],
        ),
      ),
    );
  }
}
