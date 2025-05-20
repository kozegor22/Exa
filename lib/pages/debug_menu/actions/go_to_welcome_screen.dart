import 'package:flutter/material.dart';

class GoToWelcomeScreen extends StatelessWidget {
  const GoToWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'welcome_screen');
      },
      child: Text("welcome_screen"),
    );
  }
}
