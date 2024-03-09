import 'package:flutter/foundation.dart';

import 'card/playing_card.dart';

class Player extends ChangeNotifier {
  static const maxCards = 7;

  final List<PlayingCard> hand =
      // List.generate(maxCards, (index) => PlayingCard.random());
      List.generate(maxCards, (index) => PlayingCard.draw());

  void removeCard(PlayingCard card) {
    hand.remove(card);
    notifyListeners();
  }
}