import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelp {
  DBhelp._();

  static final DBhelp  getinstance = DBhelp._();

  static final String TABLE_NAME = 'History';
  static final String COLUMN1_TEXT = 'Text';
  static final String COLUMN2_TIME = 'Time';
  static final String COLUMN3_TYPE = 'Type';
  static final String S_NO = 'sno';

  Database? myDB;
  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDb();
      return myDB!;
    }
  }

  Future<Database> openDb() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String DBpath = join(appdir.path, 'history.db');
    return await openDatabase(
      DBpath,
      onCreate: (db, version) {
        db.execute(
          'create table $TABLE_NAME  ( $S_NO integer primary key autoincrement , $COLUMN1_TEXT text , $COLUMN2_TIME text  ,$COLUMN3_TYPE text )',
        );
      },
      version: 1,
    );
  }

  //all quries

  Future<bool> addhistory({
    required String mtext,
    required String mtime,
    required String mtype,
  }) async {
    var db = await getDB();
    int rowseffected = await db.insert(TABLE_NAME, {
      COLUMN1_TEXT: mtext,
      COLUMN2_TIME: mtime,
      COLUMN3_TYPE: mtype,
    });
    return rowseffected > 0;
  }

  Future<bool> deletehistory({required int msno}) async {
    var db = await getDB();
    int rowseffected = await db.delete(
      TABLE_NAME,
      where: '$S_NO=?',
      whereArgs: [msno],
    );
    return rowseffected > 0;
  }

  Future<List<Map<String, dynamic>>> allhistory() async {
    var db = await getDB();
    List<Map<String, dynamic>> mhistory = await db.query(TABLE_NAME);
    return mhistory;
  }
}
