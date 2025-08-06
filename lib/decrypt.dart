import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickmaths/provider/dbprovider.dart';
import 'package:quickmaths/provider/decrypt_provider.dart';

class DecryptTab extends StatefulWidget {
  @override
  State<DecryptTab> createState() => _decryptTabState();
}

class _decryptTabState extends State<DecryptTab> {
  String decryptedtext = '';
  TextEditingController decrypt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: decrypt,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter text to be decrypted',
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
            Consumer2<Historyprovider, DecryptProvider>(
              builder: (ctx, pro, decrpyted, child) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(11),
                  ),
                ),
                onPressed: () async {
                  if(decrpyted.deresult.isNotEmpty){
                    decrypt.text='';
                    decrpyted.clear();
                  }else{
                  decrpyted.decrypt(decrypt.text);
                  String time = DateTime.now().toString().split('.')[0];
                  pro.adddetail(text: decrpyted.deresult, time: time, type: 'Decrypt');}
                },
                child: Text(
                  decrpyted.deresult.isNotEmpty? 'Clear':
                  'Decrypt',
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
              child: Consumer<DecryptProvider>(
                builder: (ctx, val, child) => Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Clipboard.setData(ClipboardData(text: val.deresult));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.cyan,
                            content: Center(child: Text('Copied to clipboard')),
                          ),
                        );
                      },
                      child: Text(
                        val.deresult.isNotEmpty
                            ? val.deresult
                            : '🔓Decrypted text will appear here',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    if (val.deresult.isNotEmpty)
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
}

// String reverse(String input) {
//   return input.split('').reversed.join('');
// }
