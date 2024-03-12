// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:battlelineflutter/game_internals/game_phase.dart';

import 'player.dart';
import 'playing_area.dart';

class BoardState {
  // final VoidCallback onWin;

  static final PlayingArea areaOne = PlayingArea();
  static final PlayingArea areaTwo = PlayingArea();
  static final PlayingArea areaThree = PlayingArea();
  static final PlayingArea areaFour = PlayingArea();
  static final PlayingArea areaFive = PlayingArea();
  static final PlayingArea areaSix = PlayingArea();
  static final PlayingArea areaSeven = PlayingArea();
  static final PlayingArea areaEight = PlayingArea();
  static final PlayingArea areaNine = PlayingArea();

  final Player player = Player();

  GamePhaseManager gamePhaseManager = GamePhaseManager();

  // BoardState({required this.onWin}) {
  //   player.addListener(_handlePlayerChange);
  // }

  BoardState() {
    player.addListener(_handlePlayerChange);
  }

  static List<PlayingArea> get areas => [
        areaOne,
        areaTwo,
        areaThree,
        areaFour,
        areaFive,
        areaSix,
        areaSeven,
        areaEight,
        areaNine
      ];

  void dispose() {
    player.removeListener(_handlePlayerChange);
    areaOne.dispose();
    areaTwo.dispose();
  }

  void _handlePlayerChange() {
    if (player.plyerhand.isEmpty) {
      // onWin();
    }
    if (player.plyerhand.length == 6) {
      gamePhaseManager.setPhase(GamePhase.Draw);
    }
  }
}
