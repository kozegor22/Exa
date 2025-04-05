import 'package:flutter/material.dart';

class GoToLearnedList extends StatelessWidget {
  const GoToLearnedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'learned_list');
      },
      child: Text("Таблица изученных билетов"),
    );
  }
}
