import 'dart:math';

import 'package:battlelineflutter/game_internals/board_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/card/playing_card.dart';
import '../game_internals/playing_area.dart';
import '../style/palette.dart';
import 'playing_card_widget.dart';

class PlayingAreaWidget extends StatefulWidget {
  final PlayingArea area;

  const PlayingAreaWidget(this.area, {super.key});

  @override
  State<PlayingAreaWidget> createState() => _PlayingAreaWidgetState();
}

class _PlayingAreaWidgetState extends State<PlayingAreaWidget> {
  bool isHighlighted = false;

  Widget Redporn() {
    return Center(
      child: Image.asset('icons/prize.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Container(
      child: Column(
        children: [
          opponentArea(context, palette),
          Redporn(),
          playerArea(context, palette),
        ],
      ),
    );
  }

  Widget opponentArea(BuildContext context, Palette palette) {
    return LimitedBox(
      maxHeight: 200,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DragTarget<PlayingCardDragData>(
          builder: (context, candidateData, rejectedData) => Material(
            color: palette.trueWhite,
            shape: RoundedRectangleBorder(),
            clipBehavior: Clip.hardEdge,
            // child: InkWell(
            //   splashColor: palette.redPen,
            //   onTap: _onAreaTap,
            //   child: StreamBuilder(
            //     // Rebuild the card stack whenever the area changes
            //     // (either by a player action, or remotely).
            //     stream: widget.area.allChanges,
            //     builder: (context, child) => _CardStack(widget.area.cards),
            //   ),
            // ),
          ),
          onWillAcceptWithDetails: _onDragWillAccept,
          onLeave: _onDragLeave,
          onAcceptWithDetails: _onDragAccept,
        ),
      ),
    );
  }

  Widget playerArea(BuildContext context, Palette palette) {
    return LimitedBox(
      maxHeight: 200,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DragTarget<PlayingCardDragData>(
          builder: (context, candidateData, rejectedData) => Material(
            color: isHighlighted ? palette.accept : palette.trueWhite,
            shape: RoundedRectangleBorder(),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: palette.redPen,
              onTap: _onAreaTap,
              child: StreamBuilder(
                // Rebuild the card stack whenever the area changes
                // (either by a player action, or remotely).
                stream: widget.area.allChanges,
                builder: (context, child) => _CardStack(widget.area.cards),
              ),
            ),
          ),
          onWillAcceptWithDetails: _onDragWillAccept,
          onLeave: _onDragLeave,
          onAcceptWithDetails: _onDragAccept,
        ),
      ),
    );
  }

  void _onAreaTap() {
    // widget.area.removeFirstCard();

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.huhsh);
  }

  void _onDragAccept(DragTargetDetails<PlayingCardDragData> details) {
    print("_onDragAccept");
    widget.area.acceptCard(details.data.card);
    // details.data.holder.removeCard(details.data.card);
    setState(() => isHighlighted = false);
  }

  void _onDragLeave(PlayingCardDragData? data) {
    print("_onDragLeave");
    setState(() => isHighlighted = false);
  }

  bool _onDragWillAccept(DragTargetDetails<PlayingCardDragData> details) {
    print("_onDragWillAccept");
    if (widget.area.cards.length == 3) return false;
    if (BoardState.isPlacedCard) return false;
    setState(() => isHighlighted = true);
    return true;
  }
}

class _CardStack extends StatelessWidget {
  static const int _maxCards = 3;

  static const _leftOffset = 0.0;

  static const _topOffset = 5.0;

  static const double _maxWidth =
      _maxCards * _leftOffset + PlayingCardWidget.width;

  static const _maxHeight =
      _maxCards * _topOffset * 5 + PlayingCardWidget.height;

  final List<PlayingCard> cards;

  const _CardStack(this.cards);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // color: Colors.black,
        width: _maxWidth,
        height: _maxHeight,
        child: Stack(
          children: [
            for (var i = max(0, cards.length - _maxCards);
                i < cards.length;
                i++)
              Positioned(
                top: i * 5 * _topOffset,
                // left: _leftOffset,
                child: PlayingCardWidget(cards[i]),
              ),
          ],
        ),
      ),
    );
  }
}
