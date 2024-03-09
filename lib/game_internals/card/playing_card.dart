import 'dart:math';

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
        2 + random.nextInt(9), CardColor.values[random.nextInt(7)]);
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
