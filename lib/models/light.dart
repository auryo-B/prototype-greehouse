import 'package:flutter/foundation.dart';

class Light extends ChangeNotifier {
  String label;
  bool turn;

  Light(this.label, this.turn);

  void toggleLight() {
    turn = !turn;
    notifyListeners();
  }
}
