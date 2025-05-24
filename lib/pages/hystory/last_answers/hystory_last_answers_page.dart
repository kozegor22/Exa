import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_last_answers.dart';
import 'package:flutter_application_1/pages/hystory/results/results.dart';

class HystoryLastAnswersPage extends StatefulWidget {
  const HystoryLastAnswersPage({super.key});

  @override
  State<HystoryLastAnswersPage> createState() => _HystoryLastAnswersPageState();
}

class _HystoryLastAnswersPageState extends State<HystoryLastAnswersPage> {
  @override
  void initState() {
    super.initState();
    //HystoryLastAnswers.load();
    setState(() {});
  }

  Widget didHeAnswer() {
    if (HystoryLastAnswers.ticketIds[0] != -1) {
      return ListView.builder(
        itemCount: HystoryLastAnswers.ticketIds.length,
        itemBuilder: (context, index) => loadLastAnswer(index),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Здесь пусто :(",style: TextStyle(fontSize: 40),),)
      ],
    );
  }

  Widget loadLastAnswer(int index) {
    if (HystoryLastAnswers.ticketIds[index] != -1) {
      return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => Results(
                    id: HystoryLastAnswers.ticketIds[index],
                    score: HystoryLastAnswers.scores[index],
                    inputType: false,
                    feedback: HystoryLastAnswers.feedbacks[index],
                  ),
            ),
          );
        },
        child: Text(
          "Билет ${HystoryLastAnswers.ticketIds[index]}:${HystoryLastAnswers.scores[index]}/100",
        ),
      );
    }
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Последние ответы"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: didHeAnswer()
    );
  }
}
