import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.score});
  final int score;
  @override
  State<ScorePage> createState() => _ScorePageState();
}

String grade(int score) {
  if (score >= 85) {
    return "Замечательно ^_^";
  } else if (score >= 75 && score <= 84) {
    HystoryLearned.saveLearned();
    return "Хорошо :)";
  } else if (score >= 55 && score <= 74) {
    return "Надо подучить -_-";
  }
  return "Плохо :(";
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Text(grade(widget.score), style: TextStyle(fontSize: 30))),
        Center(child: Text("${widget.score}/100", style: TextStyle(fontSize: 40))),
      ],
    );
  }
}
