import 'package:flutter/cupertino.dart';

enum GamePhase {
  Setup,
  PlayerTurn,
  Main,
  Draw,
  Judge,
  OpponentTurn,
  End,
}

class GamePhaseManager extends ChangeNotifier {
  static final GamePhaseManager _instance = GamePhaseManager._internal();

  factory GamePhaseManager() {
    return _instance;
  }

  GamePhase _currentPhase = GamePhase.Setup;

  GamePhase get currentPhase => _currentPhase;

  setPhase(GamePhase phase) {
    _currentPhase = phase;
    notifyListeners();
  }

  GamePhaseManager._internal();
}
