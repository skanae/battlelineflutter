// Copyright 2023, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:battlelineflutter/game_internals/game_phase.dart';
import 'package:battlelineflutter/game_internals/player.dart';
import 'package:battlelineflutter/play_session/playing_card_widget.dart';
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
  final Player player = Player();
  final GamePhaseManager gamePhaseManager = GamePhaseManager();

  @override
  Widget build(BuildContext context) {
    final boardState = context.watch<BoardState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OpponentHandWidget(), //Stateless
        nineCardPlacementAndPrize(boardState),
        myHandAndTwoDeck(),
      ],
    );
  }

  Widget nineCardPlacementAndPrize(BoardState boardState) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: PlayingAreaWidget(BoardState.areaOne)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaTwo)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaThree)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaFour)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaFive)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaSix)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaSeven)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaEight)),
          SizedBox(width: 20),
          Expanded(child: PlayingAreaWidget(BoardState.areaNine)),
        ],
      ),
    );
  }

  Widget myHandAndTwoDeck() {
    return Row(
      children: [
        Spacer(),
        tatticsCardsDeck(),
        SizedBox(
          width: 57.1,
        ),
        PlayerHandWidget(),
        SizedBox(
          width: 57.1,
        ),
        NumberCardsDeck(),
        Spacer(),
      ],
    );
  }

  Widget deck(int numberOfCards) {
    return SizedBox(
      width: 57.1,
      height: 88.9 + 12,
      child: Stack(
        children: [
          for (var i = 0; i < numberOfCards; i++)
            Positioned(
              top: i * 0.2,
              child: cardBack(context),
            ),
        ],
      ),
    );
  }

  Widget tatticsCardsDeck() {
    return GestureDetector(
      child: deck(10),
      onTap: () {
        print("tatticsCardsDeck tapped");
      },
    );
  }

  Widget NumberCardsDeck() {
    return GestureDetector(
      child: deck(46),
      onTap: () {
        print("NumberCardsDeck tapped");
        if (gamePhaseManager.currentPhase == GamePhase.Draw) {
          toNextPhase();
        }
      },
    );
  }

  void toNextPhase() {
    setState(() {
      player.drawCardFromNumberCardsDeck(); //カード引く
      oponentTurn();
      gamePhaseManager.setPhase(GamePhase.PlayerTurn);
    });
  }

  void oponentTurn() {
    //カードの選択、ドロー、UIの更新
    ///TODO opponentに影響を及ぼす
    var random = math.Random();
    var currentPlayCard = player.opponentHand[random.nextInt(7)];
    print(currentPlayCard);
    print(player.opponentHand);
    // PlayingArea playingArea = PlayingArea();
    // playingArea.acceptOpponentCard(currentPlayCard);
    for (var area in BoardState.areas) {
      if (area.opponentCards.length < 3) {
        area.acceptOpponentCard(currentPlayCard);
        player.removeOpponentCard(currentPlayCard);
        player.drawCardFromNumberCardsDeckOP();
        print(player.opponentHand);
        gamePhaseManager.setPhase(GamePhase.PlayerTurn);
        return;
      }
    }
  }
}

Widget cardBack(BuildContext context) {
  const double width = 57.1;
  const double height = 88.9;
  return DefaultTextStyle(
    style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
    child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          border: Border.all(color: Colors.grey, width: 0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Image.asset("icons/card_back.png"),
        )),
  );
}

//相手側の7枚のカード
class OpponentHandWidget extends StatelessWidget {
  const OpponentHandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> opponentHandCards = List.generate(
      7, // Number of cards you want to display
      (index) => cardBack(context),
    );
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: PlayingCardWidget.height),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              ...opponentHandCards,
            ],
          )),
    );
  }
}
