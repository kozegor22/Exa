import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_best_answers.dart';
import 'package:flutter_application_1/data/hystory_last_answers.dart';
import 'package:flutter_application_1/data/hystory_statistics.dart';

class Fakecheckans extends StatelessWidget {
  const Fakecheckans({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        TextEditingController input = TextEditingController();
        TextEditingController input1 = TextEditingController();
        TextEditingController input2 = TextEditingController();
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("Options"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: input,
                      decoration: InputDecoration(hint: Text("id")),
                    ),
                    TextField(
                      controller: input1,
                      decoration: InputDecoration(hint: Text("score")),
                    ),
                    TextField(
                      controller: input2,
                      decoration: InputDecoration(hint: Text("aifeedback")),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (input.text == "" ||
                          input1.text == "" ||
                          input2.text == "") {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text("null value"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("ok"),
                                  ),
                                ],
                              ),
                        );
                      } else {
                        if (HystoryStatistics
                                .hystoryStats[int.parse(input.text) - 1] <
                            int.parse(input.text)) {
                          HystoryBestAnswers.hystoryBestAnswers[int.parse(
                                input.text,
                              ) -
                              1] = [input2.text];
                          HystoryBestAnswers.save();
                          HystoryStatistics.hystoryStats[int.parse(input.text) -
                              1] = int.parse(input.text);
                          HystoryStatistics.save();
                        }
                        HystoryLastAnswers.load();
                        for (int i = HystoryLastAnswers.ticketIds.length -1 ; i > 0; i--) {
                          HystoryLastAnswers.feedbacks[i] =
                              HystoryLastAnswers.feedbacks[i - 1];
                          HystoryLastAnswers.scores[i] =
                              HystoryLastAnswers.scores[i - 1];
                          HystoryLastAnswers.ticketIds[i] =
                              HystoryLastAnswers.ticketIds[i - 1];
                        }
                        HystoryLastAnswers.feedbacks[0] = [input2.text];
                        HystoryLastAnswers.scores[0] = int.parse(input1.text);
                        HystoryLastAnswers.ticketIds[0] = int.parse(input.text);
                        HystoryLastAnswers.save();
                      }
                    },
                    child: Text("ok"),
                  ),
                ],
              ),
        );
      },
      child: Text("fake_check_ans"),
    );
  }
}
