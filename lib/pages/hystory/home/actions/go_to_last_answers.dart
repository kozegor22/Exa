import 'package:flutter/material.dart';

class GoToLastAnswers extends StatelessWidget {
  const GoToLastAnswers({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'hystory_last_answers_page');
      },
      child: Text("Последние ответы"),
    );
  }
}
