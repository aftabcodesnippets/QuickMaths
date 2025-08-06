import 'package:flutter/material.dart';
import 'package:quickmaths/decrypt.dart';
import 'package:quickmaths/enctypt.dart';
import 'package:quickmaths/history.dart';
import 'package:quickmaths/settings.dart';

class Encryption extends StatefulWidget {
  @override
  State<Encryption> createState() => _EncryptionState();
}

class _EncryptionState extends State<Encryption> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: Colors.cyan, size: 30),
                          Text('Settings'),
                        ],
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
          title: Text(
            'CipherLab',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
          ),
          bottom: TabBar(
            dividerColor: Colors.cyan,
            labelColor: Colors.cyan,
            indicatorColor: Colors.cyan,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            dividerHeight: 2,

            tabs: [
              Tab(icon: Icon(Icons.lock ,color: Colors.blue,), text: 'Encrypt'),
              Tab(icon: Icon(Icons.lock_open ,color: Colors.green,), text: 'Decrypt'),
              Tab(icon: Icon(Icons.history ,color: Colors.grey,), text: 'History'),
            ],
          ),
        ),
        body: TabBarView(children: [EncryptTab(), DecryptTab(), HistoryTab()]),
      ),
    );
  }
}
