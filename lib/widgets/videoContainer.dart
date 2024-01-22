import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class VideoContainer extends ConsumerWidget {
  const VideoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Build VideoContainer!");
    const String video = 'assets/ForBiggerFun.mp4';
    ref.read(playerProvider.notifier).loadVideo(video);
    return Container(
      alignment: Alignment.center,
      child: Video(
        controller: VideoController(ref.watch(playerProvider)),
        controls: NoVideoControls,
      ),
    );
  }
}
