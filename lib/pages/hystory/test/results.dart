import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';

result<String>(score, id) {
  if (score >= 90) {
    HystoryLearned.hystoryLearned[id - 1] = true;
    HystoryLearned.saveLearned();
    return "Замечательно";
  } else if (score >= 65) {
    HystoryLearned.hystoryLearned[id - 1] = true;
    HystoryLearned.saveLearned();
    return "Более менее";
  }
  return "Надо подучить";
}

class Results extends StatefulWidget {
  const Results({
    super.key,
    required this.id,
    required this.score,
    required this.inputType,
  });
  final bool inputType;
  final int id;
  final int score;
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Результаты билет ${widget.id}"),
        centerTitle: true,
        leading: null,

        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${result(widget.score, widget.id)}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.score}/100",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    if (widget.inputType) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Продолжить"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
