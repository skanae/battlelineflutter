// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:battlelineflutter/game_internals/game_phase.dart';
import 'package:flutter/foundation.dart';

import 'player.dart';
import 'playing_area.dart';

class BoardState {
  final VoidCallback onWin;

  final PlayingArea areaOne = PlayingArea();
  final PlayingArea areaTwo = PlayingArea();
  final PlayingArea areaThree = PlayingArea();
  final PlayingArea areaFour = PlayingArea();
  final PlayingArea areaFive = PlayingArea();
  final PlayingArea areaSix = PlayingArea();
  final PlayingArea areaSeven = PlayingArea();
  final PlayingArea areaEight = PlayingArea();
  final PlayingArea areaNine = PlayingArea();

  final Player player = Player();

  GamePhaseManager gamePhaseManager = GamePhaseManager();

  BoardState({required this.onWin}) {
    player.addListener(_handlePlayerChange);
  }

  List<PlayingArea> get areas => [areaOne, areaTwo];

  void dispose() {
    player.removeListener(_handlePlayerChange);
    areaOne.dispose();
    areaTwo.dispose();
  }

  void _handlePlayerChange() {
    if (player.plyerhand.isEmpty) {
      onWin();
    }
    if (player.plyerhand.length == 6) {
      gamePhaseManager.setPhase(GamePhase.Draw);
    }
  }
}
