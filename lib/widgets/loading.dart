import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Color(0x00ffffff),
      ),
    );
  }
}
