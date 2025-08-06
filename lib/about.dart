import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About QuickMaths',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QuickMaths is a versatile calculator app that serves as the first screen, providing you with powerful and easy-to-use calculation tools.',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 15),
            Text(
              'For enhanced security, access to the CipherLab feature — which includes encryption, decryption, and history functionalities — is protected by a password you set within the app.',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 15),
            Text(
              'Developed and maintained by NAJAF_DEVS.',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
