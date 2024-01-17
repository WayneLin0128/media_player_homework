import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:media_player_homework/provider/player_state.dart';

// class SeekBar extends StatefulWidget {
//   final Player player;
//   const SeekBar({
//     Key? key,
//     required this.player,
//   }) : super(key: key);

//   @override
//   State<SeekBar> createState() => _SeekBarState();
// }

class SeekBar extends ConsumerWidget {
  SeekBar({super.key});
  bool seeking = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // late Duration position = widget.player.state.position;
    final playerRef = ref.read(playerStateProvider);
    Duration position = playerRef.player.state.position;
    // playerRef.init();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(width: 24.0),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: ref.read(playerStateProvider).onPlay,
                    icon: Icon(
                      ref.read(playerStateProvider).isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    color: Theme.of(context).primaryColor,
                    iconSize: 36.0,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: ref.read(playerStateProvider).onStop,
                    icon: const Icon(
                      Icons.stop,
                    ),
                    color: Theme.of(context).primaryColor,
                    iconSize: 36.0,
                  ),
                ),
                // const SizedBox(width: 24.0),
                Text(ref
                    .read(playerStateProvider)
                    .player
                    .state
                    .position
                    .toString()
                    .substring(2, 7)),
                Expanded(
                  flex: 8,
                  child: Slider(
                    min: 0.0,
                    max: ref
                        .read(playerStateProvider)
                        .player
                        .state
                        .position
                        .inMilliseconds
                        .toDouble()
                        .clamp(
                          0.0,
                          ref
                              .read(playerStateProvider)
                              .player
                              .state
                              .duration
                              .inMilliseconds
                              .toDouble(),
                        ),
                    value: ref.watch(playerStateProvider).seekbarValue,
                    // secondaryTrackValue: playerRef
                    //     .player.state.buffer.inMilliseconds
                    //     .toDouble()
                    //     .clamp(
                    //       0.0,
                    //       playerRef.player.state.duration.inMilliseconds
                    //           .toDouble(),
                    //     ),
                    // onChangeStart: (e) {
                    //   seeking = true;
                    // },
                    onChanged: ref.read(playerStateProvider).changeSeekbar,
                    // playerRef.player.state.position.inMilliseconds > 0
                    //     ? (e) {
                    //         position = Duration(milliseconds: e ~/ 1);
                    //       }
                    //     : null,
                    // onChangeEnd: (e) {
                    //   seeking = true;
                    //   playerRef.player.seek(Duration(milliseconds: e ~/ 1));
                    // },
                  ),
                ),
                Text(playerRef.duration.toString().substring(2, 7)),
                const SizedBox(width: 24.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
