// ignore_for_file: use_build_context_synchronously

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

Future<bool> checkApiKey(String key, BuildContext context) async {
  bool requestState = false;
  OpenAI.baseUrl = "https://api.zukijourney.com";
  OpenAI.apiKey = key;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(title: Text("Проверка ключа")),
  );
  try {
    await OpenAI.instance.chat.create(
      model: "gpt-4o",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Выведи мне число 911 и больше ничего",
            ),
          ],
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
  } on RequestFailedException catch (e) {
    if (e.statusCode == 401) {
      Navigator.of(context).pop;
      requestState = true;
      showDialog(
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
      Navigator.of(context).pop;
      requestState = true;
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
  Navigator.of(context).pop;
  return requestState;
}
