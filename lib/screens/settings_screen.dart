import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text('Please allow location!!'),
            const Text('settings'),
          ],
        ),
      ),
    );
  }
}
