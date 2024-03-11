import 'package:flutter/foundation.dart';

import 'card/playing_card.dart';

class Player extends ChangeNotifier {
  static const maxCards = 7;

  List<PlayingCard> get plyerhand => _plyerhand;
  List<PlayingCard> get opponentHand => _opponentHand;

  static List<PlayingCard> _plyerhand =
      List.generate(maxCards, (index) => PlayingCard.draw());

  static List<PlayingCard> _opponentHand =
      List.generate(maxCards, (index) => PlayingCard.draw());

  // void removeCard(PlayingCard card) {
  //   _plyerhand.remove(card);
  //   notifyListeners();
  // }

  void drawCardFromNumberCardsDeck() {
    _plyerhand.add(PlayingCard.draw());
    notifyListeners();
  }

  void drawCardFromNumberCardsDeckOP() {
    _opponentHand.add(PlayingCard.draw());
    notifyListeners();
  }
}
