import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

import 'package:media_player_homework/widgets/videoContainer.dart';
import 'package:media_player_homework/widgets/playPauseButton.dart';
import 'package:media_player_homework/widgets/stopButton.dart';
import 'package:media_player_homework/widgets/seekbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String video = 'assets/ForBiggerFun.mp4';
    Player player = Player();
    player.open(Media(video), play: false);
    player.setVolume(70);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Media player',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: VideoContainer(player: player),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PlayPauseButton(player: player),
                      StopButton(player: player),
                      SeekBar(player: player),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
