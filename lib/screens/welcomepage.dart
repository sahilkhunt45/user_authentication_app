import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? username;
  welcomePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('currentUser');

    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed('homepage');
    });
  }

  @override
  void initState() {
    super.initState();

    welcomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 240,
            ),
            const SizedBox(height: 12),
            Text(
              "Welcome,$username",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
