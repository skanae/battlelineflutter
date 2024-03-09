import 'dart:math';

import 'package:battlelineflutter/game_internals/card/card_deck.dart';
import 'package:flutter/foundation.dart';

import 'card_color.dart';

@immutable
class PlayingCard {
  static final _random = Random();

  final CardColor cardcolor;

  final int value;

  const PlayingCard(this.value, this.cardcolor);

  // factory PlayingCard.fromJson(Map<String, dynamic> json) {
  //   return PlayingCard(
  //     CardSuit.values
  //         .singleWhere((e) => e.internalRepresentation == json['suit']),
  //     json['value'] as int,
  //   );
  // }

  factory PlayingCard.random([Random? random]) {
    random ??= _random;
    return PlayingCard(
        2 + random.nextInt(9), CardColor.values[random.nextInt(6)]);
  }

  factory PlayingCard.draw([Random? random]) {
    final CardDeck cardDeck = CardDeck();
    return cardDeck.drawCard();
  }

  // @override
  // int get hashCode => Object.hash(value);

  @override
  bool operator ==(Object other) {
    return other is PlayingCard && other.value == value;
  }

  Map<String, dynamic> toJson() => {
        // 'suit': suit.internalRepresentation,
        'value': value,
      };

  @override
  String toString() {
    return '$cardcolor$value';
  }
}
