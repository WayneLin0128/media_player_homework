import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_player_homework/provider/player_provider.dart';

class PlayPauseButton extends ConsumerStatefulWidget {
  const PlayPauseButton({
    super.key,
  });

  @override
  PlayPauseButtonState createState() => PlayPauseButtonState();
}

class PlayPauseButtonState extends ConsumerState<PlayPauseButton> {
  late bool playing = ref.watch(playerProvider).state.playing;
  @override
  void initState() {
    super.initState();
    playing = ref.read(playerProvider).state.playing;
    ref.read(playerProvider).stream.playing.listen((event) {
      setState(() {
        playing = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => ref.read(playerProvider).playOrPause(),
      icon: Icon(
        playing ? Icons.pause : Icons.play_arrow,
      ),
      color: Theme.of(context).primaryColor,
      iconSize: 36.0,
    );
  }
}
