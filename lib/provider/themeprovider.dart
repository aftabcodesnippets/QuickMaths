import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier{
bool   _isDarkModeEnabled=false;

bool changemode()=> _isDarkModeEnabled;
void updatetheme ( {required value}){
  _isDarkModeEnabled =value;
  notifyListeners();
}

}