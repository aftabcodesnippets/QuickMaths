import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickmaths/database.dart';
import 'package:quickmaths/provider/dbprovider.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class Historyitems {
  final int sno;
  final String text;
  final String time;
  final String type;

  Historyitems({
    required this.text,
    required this.time,
    required this.type,
    required this.sno,
  });
}

class _HistoryTabState extends State<HistoryTab> {
  List<Historyitems> historylist = [];

  void loadhistory() async {
    final rawlist = await DBhelp.getinstance.allhistory();
    historylist = rawlist
        .map(
          (item) => Historyitems(
            sno: item['sno'] ?? 0,
            text: item['Text'] ?? "",
            time: item['Time'] ?? "",
            type: item['Type'] ?? "",
          ),
        )
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadhistory();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historylist.length,
      itemBuilder: (_, index) {
        final item = historylist[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(11),
          ),

          child: ListTile(
            title: Text(item.text),
            subtitle: Text(
              DateFormat(
                'yyyy-MM-dd hh:mm a',
              ).format(DateTime.parse(item.time)),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.cyan,

                          content: Center(
                            child: Text(
                              "Copied to clipboard",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Row(children: [Icon(Icons.copy)]),
                  ),
                  Consumer<Historyprovider>(
                    builder: (ctx, pro, child) => IconButton(
                      onPressed: () async {
                        final shoulddelete = await showDialog(
                          context: context,

                          builder: (_) => AlertDialog(
                            title: Text('Delete this entry?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        );
                        if (shoulddelete == true) {
                         pro.delldetails(sno: item.sno);
                          loadhistory();
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            leading: item.type == 'Encrypt'
                ? Icon(Icons.lock)
                : Icon(Icons.lock_open),
            iconColor: item.type == 'Encrypt' ? Colors.blue : Colors.green,
          ),
        );
      },
    );
  }
}
