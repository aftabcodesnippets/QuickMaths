import 'package:flutter/material.dart';

class DecryptProvider  extends ChangeNotifier{
   String _deresult ='';
   String get deresult => _deresult;

   
  void decrypt(String decrypt2) {
    _deresult= decrypt2.runes.map((int rune) {
      return String.fromCharCode(rune + 9);
    }).join();
    notifyListeners();
  }

  void clear(){
    _deresult='';
    notifyListeners();
  }


}