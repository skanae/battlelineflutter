import 'package:battlelineflutter/game_internals/card/card_color.dart';
import 'package:battlelineflutter/game_internals/card/playing_card.dart';

class CardDeck {
  // コンストラクタ（private）
  CardDeck._internal();
  // インスタンスはただ１つだけ
  static final CardDeck instance = CardDeck._internal();
  // キャッシュしたインスタンスを返す
  factory CardDeck() => instance;

  List<PlayingCard> _deck = [];

  // カードデッキを取得するメソッド
  List<PlayingCard> get deck => _deck;

  void initializeDeck() {
    print("card Deck initialize");
    for (var color in CardColor.values) {
      if (color == CardColor.black || color == CardColor.other) {
        continue;
      }
      for (int i = 0; i < 10; i++) {
        _deck.add(PlayingCard(i + 1, color));
      }
    }
    _deck.shuffle();
  }

  void tasikame() {
    print(_deck.toString());
  }

  PlayingCard drawCard() {
    if (_deck.isNotEmpty) {
      print("card Deck draw ${_deck.first}");
      return _deck.removeAt(0);
    } else {
      return PlayingCard(1, CardColor.other);
    }
  }
}

//
// class ParentWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Provider<T>() で子Widgetにデータを渡す
//     // ※ 渡すデータの クラス と <T> は揃えましょう
//     return Provider<CountData>.value(
//       // 渡すデータ
//       create: (context) => CountData(),
//       child: Container(
//         child: ChildWidget(),
//       ),
//     );
//   }
// }
