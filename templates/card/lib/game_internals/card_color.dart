import 'package:flutter/material.dart';

enum CardColor {
  blue,
  green,
  orange,
  purple,
  red,
  yellow,
  black,
  other;

  Color get asColor {
    switch (this) {
      case CardColor.blue:
        return Colors.blue;
      case CardColor.green:
        return Colors.green;
      case CardColor.orange:
        return Colors.orange;
      case CardColor.purple:
        return Colors.purple;
      case CardColor.red:
        return Colors.red;
      case CardColor.yellow:
        return Colors.yellow;
      case CardColor.black:
        return Colors.black;
      case CardColor.other:
        return Colors.transparent;
    }
  }
}
// final int internalRepresentation;

// const CardSuit(this.internalRepresentation);

// String get asCharacter {
//   switch (this) {
//     case CardSuit.spades:
//       return '♠';
//     case CardSuit.hearts:
//       return '♥';
//     case CardSuit.diamonds:
//       return '♦';
//     case CardSuit.clubs:
//       return '♣';
//   }
// }

// CardSuitColor get color {
//   switch (this) {
//     case CardSuit.spades:
//     case CardSuit.clubs:
//       return CardSuitColor.black;
//     case CardSuit.hearts:
//     case CardSuit.diamonds:
//       return CardSuitColor.red;
//   }
// }

// @override
// String toString() => asCharacter;

// enum CardSuitColor {
//   black,
//   red,
// }
