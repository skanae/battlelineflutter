// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'player.dart';
import 'playing_area.dart';

class BoardState {
  final VoidCallback onWin;

  // final PlayingArea areaOne = PlayingArea();
  //
  // final PlayingArea areaTwo = PlayingArea();

  final PlayingArea areaOne = PlayingArea();
  final PlayingArea areaTwo = PlayingArea();
// areaThree から areaNine までのインスタンスを生成
  final PlayingArea areaThree = PlayingArea();
  final PlayingArea areaFour = PlayingArea();
  final PlayingArea areaFive = PlayingArea();
  final PlayingArea areaSix = PlayingArea();
  final PlayingArea areaSeven = PlayingArea();
  final PlayingArea areaEight = PlayingArea();
  final PlayingArea areaNine = PlayingArea();

  final Player player = Player();

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
    if (player.hand.isEmpty) {
      onWin();
    }
  }
}
