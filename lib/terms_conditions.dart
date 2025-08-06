import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading('Last Updated: Aug 05, 2025'),
            SizedBox(height: 10),
            _buildParagraph(
              'Welcome to QuickMaths, developed and maintained by NAJAF_DEVS. By downloading, accessing, or using this application, you agree to be bound by the following terms and conditions.',
            ),
            SizedBox(height: 20),

            _buildHeading('1. Use of the App'),
            _buildParagraph(
              'QuickMaths is designed to provide users with tools for encryption, decryption, mathematical utilities, and related functionalities. You agree to use this app only for lawful purposes and in accordance with all applicable laws and regulations.',
            ),
            SizedBox(height: 20),

            _buildHeading('2. User Responsibility'),
            _buildParagraph(
              'You are solely responsible for any data you input, store, or transmit using QuickMaths. NAJAF_DEVS is not responsible for any misuse of the app or consequences arising from such misuse.',
            ),
            SizedBox(height: 20),

            _buildHeading('3. Intellectual Property'),
            _buildParagraph(
              'All content, features, and design elements of QuickMaths are the property of NAJAF_DEVS and are protected by intellectual property laws. You may not reproduce, distribute, or modify any part of the app without explicit permission.',
            ),
            SizedBox(height: 20),

            _buildHeading('4. Data Privacy'),
            _buildParagraph(
              'QuickMaths does not collect or share personal information without user consent. However, we may store user preferences and local data solely on your device to improve your experience.',
            ),
            SizedBox(height: 20),

            _buildHeading('5. Updates and Modifications'),
            _buildParagraph(
              'NAJAF_DEVS reserves the right to update or modify the app and these terms at any time without prior notice. Continued use of the app following any changes constitutes your acceptance of those changes.',
            ),
            SizedBox(height: 20),

            _buildHeading('6. Limitation of Liability'),
            _buildParagraph(
              'The app is provided "as is" without warranties of any kind. NAJAF_DEVS is not liable for any direct, indirect, incidental, or consequential damages arising from the use or inability to use QuickMaths.',
            ),
            SizedBox(height: 20),

            _buildHeading('7. Termination'),
            _buildParagraph(
              'We reserve the right to suspend or terminate access to the app at our discretion, without notice, for any reason including but not limited to violation of these Terms and Conditions.',
            ),
            SizedBox(height: 40),

           SizedBox(
            width: double.infinity,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               _buildHeading('Powered by'),
              _buildParagraph('NAJAF_DEVS'),
              ],
             ),
           ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, height: 1.5),
      textAlign: TextAlign.left,
    );
  }
}
