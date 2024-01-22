import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class StopButton extends ConsumerWidget {
  const StopButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(playerProvider).pause();
        ref.read(playerProvider).seek(
              const Duration(microseconds: 0, seconds: 0),
            );
      },
      icon: const Icon(
        Icons.stop,
      ),
      color: Theme.of(context).primaryColor,
      iconSize: 36.0,
    );
  }
}
