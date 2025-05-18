// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/results/results.dart';
import 'package:flutter_application_1/scripts/history/get_ai_responce.dart';

Future<void> checkAnswer(
  String answer,
  int id,
  BuildContext context,
  String apikey,
  bool inputType,
) async {
  showDialog(
    context: context,
    builder: (context2) => AlertDialog(title: Text("ИИ обрабатывает ответ")),
    useRootNavigator: true,
  );
  List<String> aifeedback = await getAiResponce(answer, apikey, id, context);
  if (aifeedback == [""]) {
    return;
  }
  int score = 0;
  if (aifeedback.length == 1) {
    for (int i = 0; i < 100; i++) {
      try {
        int add = int.parse(aifeedback[0][i]);
        score *= 10;
        score += add;
      } on FormatException {
        break;
      } on RangeError {
        break;
      }
    }
    aifeedback[0] = aifeedback[0].replaceFirst(score.toString(), '');
    while (true) {
      if (aifeedback[0][0] == '\n') {
        aifeedback[0] = aifeedback[0].replaceFirst('\n', '');
      } else {
        break;
      }
    }
  } else {
    score = int.parse(aifeedback[0]);
  }
  Navigator.of(context, rootNavigator: true).pop();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (context) => Results(
            id: id,
            score: score,
            inputType: inputType,
            feedback: aifeedback,
          ),
    ),
  );
  return;
}
