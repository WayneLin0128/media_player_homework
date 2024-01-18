import 'package:media_kit/media_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerProvider =
    StateNotifierProvider<PlayerNotifier, Player>((ref) => PlayerNotifier());

class PlayerNotifier extends StateNotifier<Player> {
  PlayerNotifier() : super(Player());

  void loadVideo(String s) {
    state.open(
      Media(s),
      play: false,
    );
    state.setVolume(70);
  }
}
