import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/results/result_pages/ai_feedback.dart';
import 'package:flutter_application_1/pages/hystory/results/result_pages/score_page.dart';

int currentPageIndex = 0;

class Results extends StatefulWidget {
  const Results({
    super.key,
    required this.id,
    required this.score,
    required this.inputType,
    required this.feedback,
  });
  final bool inputType;
  final int id;
  final int score;
  final List<String> feedback;
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  void initState() {
    super.initState();
    currentPageIndex = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentPageIndex == 1) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            if (widget.inputType) {
              Navigator.of(context).pop();
            }
          } else {
            setState(() {
              currentPageIndex++;
            });
          }
        },
        child: Icon(Icons.arrow_right),
      ),
      appBar:
          <PreferredSizeWidget>[
            resAppBar("Результаты билет ${widget.id}"),
            resAppBar("Комментарий от ИИ"),
          ][currentPageIndex],
      body:
          <Widget>[
            ScorePage(score: widget.score, id: widget.id),
            AiFeedback(feedback: widget.feedback),
          ][currentPageIndex],
    );
  }

  AppBar resAppBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: true,
      leading: null,
      backgroundColor: Colors.deepPurpleAccent,
    );
  }
}
