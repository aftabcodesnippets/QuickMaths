
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickmaths/about.dart';
import 'package:quickmaths/global.dart';
import 'package:quickmaths/provider/themeprovider.dart';
import 'package:quickmaths/terms_conditions.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController p1 = TextEditingController();

  TextEditingController p2 = TextEditingController();

  TextEditingController p3 = TextEditingController();

  String warning = '';

  final TextStyle heading = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    super.initState();
    p1.addListener(clearfields);
    p2.addListener(clearfields);
    p3.addListener(clearfields);
  }

  @override
  void dispose() {
    p1.dispose();
    p2.dispose();
    p3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

            child: Consumer<Themeprovider>(
              builder: (ctx, provider, __) => ExpansionTile(
                collapsedBackgroundColor: Colors.transparent,
                title: Text('Appearance', style: heading),
                leading: Icon(Icons.dark_mode, color: Colors.cyan, size: 30),
                children: [
                  SwitchListTile.adaptive(
                    activeColor: Colors.cyan,
                    activeTrackColor: Colors.cyan,
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    value: provider.changemode(),
                    onChanged: (value) {
                      provider.updatetheme(value: value);
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(),

          ListTile(
            title: Text('Privacy', style: heading),
            leading: Icon(Icons.lock, color: Colors.cyan, size: 30),
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,

                builder: (context) =>ChangePasswordSheet()
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Terms & Conditions', style: heading),
            leading: Icon(Icons.description, color: Colors.cyan, size: 30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsConditions()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('About', style: heading),
            leading: Icon(Icons.info, color: Colors.cyan, size: 30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
          Divider(),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Contact Us', style: heading),
              leading: Icon(Icons.contact_mail, color: Colors.cyan, size: 30),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        '''If you have any questions, feedback, or suggestions regarding QuickMaths, feel free to reach out.
                  We're always here to help you!''',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '📧Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'aftabliaqat933@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 290),
          Column(
            children: [
              Text(
                'Powered by',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                'NAJAF_DEVS',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  void clearfields() {
    if (p1.text.isNotEmpty || p2.text.isNotEmpty || p3.text.isNotEmpty) {
      setState(() {
        warning = '';
      });
    }
  }
}



class ChangePasswordSheet extends StatefulWidget {
  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  TextEditingController p1 = TextEditingController();
  TextEditingController p2 = TextEditingController();
  TextEditingController p3 = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  String warning = '';

  @override
  void dispose() {
    p1.dispose();
    p2.dispose();
    p3.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    super.dispose();
  }

  void clearWarning() {
    if (warning.isNotEmpty) {
      setState(() => warning = '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.80,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Change App Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              _passwordField(p1, 'Enter Current Password', f1, f2),
              SizedBox(height: 15),
              _passwordField(p2, 'Enter New Password', f2, f3),
              SizedBox(height: 15),
              _passwordField(p3, 'Confirm New Password', f3, null),
              SizedBox(height: 10),
              Text('• Enter digits only', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              if (warning.isNotEmpty)
                Text(warning, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handlePasswordChange,
                child: Text('Change Password',style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordField(TextEditingController controller, String hint, FocusNode current, FocusNode? next) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
        focusNode: current,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (_) => clearWarning(),
        onSubmitted: (_) {
          if (next != null) {
            FocusScope.of(context).requestFocus(next);
          } else {
            FocusScope.of(context).unfocus(); // hide keyboard on last field
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(width: 1.5),
          ),
        ),
      ),
    );
  }

  void _handlePasswordChange() {
    if (p1.text.isEmpty || p2.text.isEmpty || p3.text.isEmpty) {
      setState(() => warning = 'Please fill all the fields !');
    } else if (p1.text != global.Password) {
      setState(() => warning = 'Wrong Current Password');
    } else if (p2.text != p3.text) {
      setState(() => warning = "New Passwords don't match!");
    } else {
      global.Password = p3.text;
      setState(() {
        warning = '';
        p1.clear();
        p2.clear();
        p3.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.cyan,
          content: Center(
            child: Text('Password Changed Successfully!', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }
}
