import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmaths/encryption.dart';
import 'package:quickmaths/global.dart';
import 'package:quickmaths/provider/themeprovider.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String input = '';
  String preview = '';

  void onButtonPressed(String label) {
    setState(() {
      if (label == 'C') {
        input = '';
        preview = '';
      } else {
        if (label == '⌫') {
          if (input.isNotEmpty) input = input.substring(0, input.length - 1);
          preview = '';
        } else {
          if (label == '=') {
            calculateresult();
          } else {
            input += label;
          }
        }
      }
    });
  }

  void calculateresult() {
    String finalInput = input.replaceAll('×', '*').replaceAll('÷', '/');

    try {
      setState(() {
        final result = _calculate(finalInput);
        preview = result.toString();
      });

      print('INPUT: $input');
      print('PREVIEW: $preview');
      print('PASSWORD: ${global.Password}');

      if (input == global.Password.toString() ||
          preview == global.Password.toString()) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Encryption()),
        );
      }
    } catch (e) {
      preview = '';
    }
  }

  dynamic _calculate(String expr) {
    final P = Parser();
    final exp = P.parse(expr);
    final evaluator = RealEvaluator();
    return evaluator.evaluate(exp);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Screen size for responsiveness
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: screenWidth * 0.12),
                Text(
                  'QuickMaths',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (_) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Consumer<Themeprovider>(
                              builder: (context, provider, child) =>
                                  Switch.adaptive(
                                    value: provider.changemode(),
                                    onChanged: (value) {
                                      provider.updatetheme(value: value);
                                    },
                                    activeColor: Colors.cyan,
                                  ),
                            ),
                            Text('Change Theme'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Calculator',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w700,
                color: Colors.cyan,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Container(height: 3, width: 100, color: Colors.cyan),
            SizedBox(height: screenHeight * 0.06),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(
                      input,
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      preview,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.cyan,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildbuttons(
                        ['C', '%', '⌫', '÷'],
                        onButtonPressed,
                        screenWidth,
                      ),
                      buildbuttons(
                        ['7', '8', '9', '×'],
                        onButtonPressed,
                        screenWidth,
                      ),
                      buildbuttons(
                        ['4', '5', '6', '-'],
                        onButtonPressed,
                        screenWidth,
                      ),
                      buildbuttons(
                        ['1', '2', '3', '+'],
                        onButtonPressed,
                        screenWidth,
                      ),
                      buildbuttons(
                        ['00', '0', '.', '='],
                        onButtonPressed,
                        screenWidth,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Responsive button builder
Widget buildbuttons(
  List<String> buttonlabels,
  Function(String) OnTap,
  double screenWidth,
) {
  return Row(
    children: buttonlabels.map((label) {
      return Expanded(
        child: SizedBox(
          height: screenWidth * 0.18,
          child: ElevatedButton(
            style: TextButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              OnTap(label);
            },
            child: Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}
