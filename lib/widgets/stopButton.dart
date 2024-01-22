import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class StopButton extends ConsumerWidget {
  // const StopButton({super.key});
  final Player player;
  const StopButton({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(playingProvider.notifier).stop(player);
        player.pause();
        player.seek(const Duration(minutes: 0, seconds: 0));
      },
      icon: const Icon(
        Icons.stop,
      ),
      color: Theme.of(context).primaryColor,
      iconSize: 36.0,
    );
  }
}
