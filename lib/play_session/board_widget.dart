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
        Row(
          children: [
            Spacer(),
            Deck(10),
            SizedBox(
              width: 57.1,
            ),
            PlayerHandWidget(),
            SizedBox(
              width: 57.1,
            ),
            Deck(60),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Widget Deck(int numberOfCards) {
    return Container(
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
