import 'package:flutter/widgets.dart';

class EncryptProvider with ChangeNotifier {
  String _result = '';

  String get result => _result;

   void encrypt(String encrypt2) {
    _result= encrypt2.runes.map((int rune) {
      return String.fromCharCode(rune - 9);
    }).join();
    notifyListeners();
  }
 void clear(){
    _result='';
    notifyListeners();
  }

}
