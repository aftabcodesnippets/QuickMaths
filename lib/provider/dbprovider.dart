import 'package:flutter/material.dart';
import 'package:quickmaths/database.dart';

class Historyprovider with ChangeNotifier {
  DBhelp dbheper;

  Historyprovider({required this.dbheper}){
    _loadhistory();
  }

  List<Map<String, dynamic>> _mData = [];

  void adddetail(  { required String text, required String time,required String type}) async {
    bool check = await dbheper.addhistory(
      mtext: text,
      mtime: time,
      mtype: type,
    );
    if (check) {
      _mData = await dbheper.allhistory();
      notifyListeners();
    }
  }

  void delldetails({required int sno}) async {
    bool check = await dbheper.deletehistory(msno: sno);
    if (check) {
      _mData = await dbheper.allhistory();
      notifyListeners();
    }
  }

  Future<void> _loadhistory() async {
    _mData = await dbheper.allhistory();
    notifyListeners();
  }
}
