import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmaths/database.dart';
import 'package:quickmaths/provider/dbprovider.dart';
import 'package:quickmaths/provider/decrypt_provider.dart';
import 'package:quickmaths/provider/encrypt_provider.dart';
import 'package:quickmaths/provider/themeprovider.dart';
import 'package:quickmaths/splashscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themeprovider()),
        ChangeNotifierProvider(
          create: (context) => Historyprovider(dbheper: DBhelp.getinstance),
        ),
        ChangeNotifierProvider(create: (context) => EncryptProvider()),
        ChangeNotifierProvider(create: (context)=>DecryptProvider())
      ],
      

      child: QuickMaths(),
    ),
  );
}

class QuickMaths extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickMaths',
      themeMode: context.watch<Themeprovider>().changemode()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(
      
      ),
      theme: ThemeData(),
      home: Splashscreen(),
    );
  }
}
