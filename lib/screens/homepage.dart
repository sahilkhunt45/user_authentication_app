import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isRemembered', false);
              await prefs.remove('currentUser');
              Navigator.of(context).pushReplacementNamed('login_register');
            },
            icon: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
