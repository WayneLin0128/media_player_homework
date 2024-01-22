import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class VideoContainer extends ConsumerWidget {
  final Player player;
  const VideoContainer({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Build VideoContainer!");
    final positionRead = ref.read(positionProvider.notifier);
    final playingStateRead = ref.read(playingProvider.notifier);
    player.stream.position.listen((event) {
      positionRead.setProgress(event.inMilliseconds.toDouble());
      debugPrint('Position: ${event.inMilliseconds.toDouble()}');
    });
    player.stream.completed.listen((event) {
      if (event) {
        playingStateRead.playOrPause(player);
      }
    });
    return Container(
      alignment: Alignment.center,
      child: Video(
        controller: VideoController(player),
        controls: NoVideoControls,
      ),
    );
  }
}
