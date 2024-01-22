import 'package:flutter/material.dart';

import 'package:media_player_homework/widgets/videoContainer.dart';
import 'package:media_player_homework/widgets/playPauseButton_new.dart';
// import 'package:media_player_homework/widgets/stopButton.dart';
// import 'package:media_player_homework/widgets/seekbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media player'),
      ),
      body: const Column(
        children: [
          Expanded(
            flex: 7,
            child: VideoContainer(),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PlayPauseButton(),
                      // StopButton(),
                      // SeekBar(),
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
