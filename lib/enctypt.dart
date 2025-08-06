import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickmaths/provider/dbprovider.dart';
import 'package:quickmaths/provider/encrypt_provider.dart';

class EncryptTab extends StatefulWidget {
  @override
  State<EncryptTab> createState() => _EncryptTabState();
}

class _EncryptTabState extends State<EncryptTab> {
  String encryptedtext = '';
  TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: input,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter text to be encrypted',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5),
                  borderRadius: BorderRadius.circular(11),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5),
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer2<Historyprovider, EncryptProvider>(
              builder: (ctx, pro, encrypted, _) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(11),
                  ),
                ),
                onPressed: () async {
                  if(encrypted.result.isNotEmpty){
                    input.text='';
                    encrypted.clear();
                  }  else{                                                                               
                  encrypted.encrypt(input.text);
                  String time = DateTime.now().toString().split('.')[0];
                  pro.adddetail(text: encrypted.result, time: time, type: 'Encrypt');}
                },
                child: Text( 
                  encrypted.result.isNotEmpty? 'Clear':
                  'Encrypt',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Consumer<EncryptProvider>(
                builder: (ctx, val, child) => Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Clipboard.setData(ClipboardData(text: val.result));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.cyan,
                            content: Center(
                              child: Text(
                                'Copied to clipboard',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        val.result.isNotEmpty
                            ? val.result
                            : '🔐Encrypted text will appear here',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    if (val.result.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Double tap to copy',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // String reversed(String toreverse) {
  //   return toreverse.split('').reversed.join('');
  // }
}
