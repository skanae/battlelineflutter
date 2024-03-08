// Copyright 2023, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:card/play_session/playing_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_internals/board_state.dart';
import 'player_hand_widget.dart';
import 'playing_area_widget.dart';

/// This widget defines the game UI itself, without things like the settings
/// button or the back button.
class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    final boardState = context.watch<BoardState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OpponentHandWidget(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: PlayingAreaWidget(boardState.areaOne)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaTwo)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaThree)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaFour)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaFive)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaSix)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaSeven)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaEight)),
              SizedBox(width: 20),
              Expanded(child: PlayingAreaWidget(boardState.areaNine)),
            ],
          ),
        ),
        PlayerHandWidget(),
      ],
    );
  }
}

class OpponentHandWidget extends StatelessWidget {
  const OpponentHandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final boardState = context.watch<BoardState>();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: PlayingCardWidget.height),
        child: ListenableBuilder(
          // Make sure we rebuild every time there's an update
          // to the player's hand.
          listenable: boardState.player,
          builder: (context, child) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                ...boardState.player.hand
                    .map((card) => PlayingCardWidget(card, player: null)),
              ],
            );
          },
        ),
      ),
    );
  }
}
