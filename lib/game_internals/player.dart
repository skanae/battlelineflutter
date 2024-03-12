import 'package:flutter/foundation.dart';

import 'card/playing_card.dart';

class Player extends ChangeNotifier {
  static const maxCards = 7;

  List<PlayingCard> get plyerhand => _plyerhand;
  List<PlayingCard> get opponentHand => _opponentHand;

  static final List<PlayingCard> _plyerhand =
      List.generate(maxCards, (index) => PlayingCard.draw());

  static final List<PlayingCard> _opponentHand =
      List.generate(maxCards, (index) => PlayingCard.draw());

  void removePlayerCard(PlayingCard card) {
    _plyerhand.remove(card);
    notifyListeners();
  }

  void removeOpponentCard(PlayingCard card) {
    opponentHand.remove(card);
    notifyListeners();
  }

  void drawCardFromNumberCardsDeck() {
    _plyerhand.add(PlayingCard.draw());
    notifyListeners();
  }

  void drawCardFromNumberCardsDeckOP() {
    _opponentHand.add(PlayingCard.draw());
    notifyListeners();
  }
}
