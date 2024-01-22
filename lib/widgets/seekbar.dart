import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class SeekBar extends ConsumerWidget {
  // const SeekBar({super.key});
  final Player player;
  const SeekBar({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Build Seekbar!");
    final positionWatch = ref.watch(positionProvider);
    final positionRead = ref.read(positionProvider.notifier);
    return Expanded(
      child: Slider(
        min: 0.0,
        max: player.state.duration.inMilliseconds.toDouble(),
        value: positionWatch,
        onChangeStart: (double position) {
          if(ref.read(playingProvider)){
            player.pause();
          }
        },
        onChanged: (double position) {
          positionRead.changeSeekbar(position);
        },
        onChangeEnd: (double position) {
          player.seek(Duration(seconds: position ~/ 1000, milliseconds: (position % 1000).toInt()));
          if(ref.read(playingProvider)) {
            player.play();
          }
        },
      ),
    );
  }
}
