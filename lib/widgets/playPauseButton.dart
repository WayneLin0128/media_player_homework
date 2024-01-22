import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class PlayPauseButton extends ConsumerWidget {
  final Player player;
  const PlayPauseButton({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Build PlayPauseButton!");
    final playingStateWatch = ref.watch(playingProvider);
    final playingStateRead = ref.read(playingProvider.notifier);
    return IconButton(
      onPressed: () {
        playingStateRead.playOrPause(player);
        player.playOrPause();
      },
      icon: Icon(playingStateWatch ? Icons.pause : Icons.play_arrow),
      color: Theme.of(context).primaryColor,
      iconSize: 36.0,
    );
  }
}
