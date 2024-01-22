import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Build PlayPauseButton!");
    // final playProviderW = ref.watch(playerProvider);
    // final playProviderWatch = ref.watch(playerProvider.notifier);
    return IconButton(
      onPressed: ref.watch(playerProvider.notifier).onPlay,
      icon: Icon(ref.watch(playerProvider).state.playing
          ? Icons.pause
          : Icons.play_arrow),
      color: Theme.of(context).primaryColor,
      iconSize: 36.0,
    );
  }
}
