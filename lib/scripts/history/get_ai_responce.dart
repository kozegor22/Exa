// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_application_1/data/tickets.dart';
import 'package:flutter/material.dart';

Future<List<String>> getAiResponce(
  String answer,
  String apikey,
  int id,
  BuildContext context,
) async {
  OpenAI.apiKey = apikey;
  bool requestFailed = false;
  late OpenAIChatCompletionModel completion;
  OpenAI.baseUrl = "https://api.zukijourney.com";
  try {
    completion = await OpenAI.instance.chat.create(
      model: "gpt-4o",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Точно следуй инструкциям.Ты учитель по истории и проверяшь ответ ученика по билету по истории Беларуси текст билета и ученика отделены знаком \"|\" ответ ученика: | $answer |  текст билета: | ${tickets[id]?[1]} | дай оценку по стобальной системе и поясни все ошибки также дай 1 строчкой число своей оценки и только его а дальше пояснение",
            ),
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
  } on RequestFailedException catch (e) {
    if (e.statusCode == 401) {
      requestFailed = true;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
  } on TimeoutException {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("TimeoutExeption"),
        content: Text("Произошла неиожиданная ошибка"),
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
  if (requestFailed == false) {
    List<String> feedback = List.filled(
      completion.choices[0].message.content!.length,
      "",
    );
    for (int i = 0; i < completion.choices[0].message.content!.length; i++) {
      feedback[i] = completion.choices[0].message.content![i].text!;
    }
    return feedback;
  }
  return [""];
}
