// ignore_for_file: use_build_context_synchronously

import 'package:flutter_application_1/data/tickets.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/test/results.dart';

Future<void> checkAnswer(
  String answer,
  int id,
  BuildContext context,
  String apikey,
  bool inputType,
) async {
  bool requestFailed = false;
  OpenAI.baseUrl = "https://api.zukijourney.com";
  OpenAI.apiKey = apikey;
  var completion;
  showDialog(
    context: context,
    builder: (context2) => AlertDialog(title: Text("ИИ обрабатывает ответ")),
    useRootNavigator: true,
  );
  try {
    completion = await OpenAI.instance.chat.create(
      model: "gpt-4o",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Ты учитель по истории и проверяшь ответ ученика по билету по истории Беларуси текст билета и ученика отделены знаком \"|\" ответ ученика: | $answer |  текст билета: | ${tickets[id]?[1]} | если не можешь ответить выдай число 101",
            ),
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
  } on RequestFailedException catch (e) {
    if (e.statusCode == 401) {
      Navigator.of(context, rootNavigator: true).pop();
      requestFailed = true;
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Неверный API ключ"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'settings');
                  },
                  child: Text("Настройки"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ок"),
                ),
              ],
            ),
      );
    } else {
      requestFailed = true;
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("${e.statusCode}"),
              content: Text(
                "${e.message}"
                "Произошла неиожиданная ошибка",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ок"),
                ),
              ],
            ),
      );
    }
  }
  if (requestFailed == false) {
    String scoreString = completion.choices[0].toString();
    int score = 0;
    // ignore: avoid_print
    print(scoreString);
    for (int i = 207; i < scoreString.length; i++) {
      if (scoreString[i] == ')') {
        break;
      }
      score *= 10;
      score += int.parse(scoreString[i]);
    }
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Results(id: id, score: score, inputType: inputType),
      ),
    );
  }

  return;
}
