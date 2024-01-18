import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_player_homework/widgets/seekbar.dart';
import 'package:media_player_homework/provider/player_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String video = 'assets/ForBiggerFun.mp4';
    ref.read(playerProvider.notifier).loadVideo(video);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media player'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              child: Video(
                controller: VideoController(ref.watch(playerProvider)),
                controls: NoVideoControls,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SeekBar(player: ref.watch(playerProvider)),
          ),
        ],
      ),
    );
  }
}
