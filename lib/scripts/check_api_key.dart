// ignore_for_file: use_build_context_synchronously

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

Future<bool> checkApiKey(String key, BuildContext context) async {
  bool requestState = false;
  OpenAI.baseUrl = "https://api.zukijourney.com";
  OpenAI.apiKey = key;
  showAdaptiveDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Row(
            children: [CircularProgressIndicator(), Text("Проверка ключа")],
          ),
        ),
  );

  try {
    await OpenAI.instance.chat.create(
      model: "gpt-4o",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Выведи мне число 1",
            ),
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    Navigator.of(context).pop();
  } on RequestFailedException catch (e) {
    Navigator.of(context).pop();
    if (e.statusCode == 401) {
      requestState = true;
      await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Неверный API ключ"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ок"),
                ),
                TextButton(onPressed: () {}, child: Text("Настройки")),
              ],
            ),
      );
    } else {
      requestState = true;
      await showDialog(
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
    return requestState;
  } on FormatException {
    Navigator.of(context).pop();
    requestState = true;
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Неверный API ключ"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ок"),
              ),
              TextButton(onPressed: () {}, child: Text("Настройки")),
            ],
          ),
    );
  }
  return requestState;
}
