// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/data/tickets.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_application_1/pages/hystory/test/results.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

TextEditingController input = TextEditingController();
String answer = "";
Future<String> getscore(String answer, int id) async {
  ApiKey.load();
  String key = ApiKey.apiKey;
  OpenAI.baseUrl = "https://api.zukijourney.com";
  OpenAI.apiKey = key;

  final completion = await OpenAI.instance.chat.create(
    model: "gpt-4o",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "Сравни эти два текста по содержанию и дай оценку от 0 до 100 и больше ничего тексты отделены знаком \"|\" | $answer |   | ${tickets[id]} | если не можешь ответить выдай число 101",
          ),
        ],
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );
  return Future.value(completion.choices[0].toString());
}

bool recording = false;
stt.SpeechToText _speech = stt.SpeechToText();
String recognizedText = "";

class Test extends StatefulWidget {
  const Test({super.key, required this.id});
  final int id;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ApiKey.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Проверка билет №${widget.id}"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            bool sure = false;
            await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text("Сдаться?"),
                    content: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Нет"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            sure = true;
                          },
                          child: Text("Да"),
                        ),
                      ],
                    ),
                  ),
            );
            if (sure == true) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Поведай мне ответ")),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (!recording) {
                      bool available = await _speech.initialize().catchError((
                        error,
                      ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Преобразование речи в тeкст не поддерживается на твоём устройстве :(",
                            ),
                          ),
                        );
                        return false;
                      });
                      if (available) {
                        setState(() {
                          recording = true;
                        });
                        _speech.listen(
                          localeId: "ru-RU",
                          onResult: (result) {
                            if (mounted) {
                              setState(() {
                                recognizedText = result.recognizedWords;
                              });
                            }
                          },
                        );
                      }
                    } else {
                      _speech.stop();
                      setState(() {
                        recording = false;
                      });
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text("ИИ обрабатывает ответ"),
                            ),
                      );
                      String scoreString = await getscore(
                        recognizedText,
                        widget.id,
                      );
                      int score = 0;
                      print(scoreString);
                      for (int i = 207; i < scoreString.length; i++) {
                        if (scoreString[i] == ')') {
                          break;
                        }
                        score *= 10;
                        score += int.parse(scoreString[i]);
                      }
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => Results(id: widget.id, score: score),
                        ),
                      );
                    }
                  },
                  child: Icon(recording ? Icons.stop : Icons.mic, size: 100),
                ),
                TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Текстовый ввод"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: input,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop;
                                      },
                                      child: Text("Отмена"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        answer = input.text;
                                        Navigator.of(context).pop;
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: Text(
                                                  "ИИ обрабатывает ответ",
                                                ),
                                              ),
                                        );
                                        String scoreString = await getscore(
                                          recognizedText,
                                          widget.id,
                                        );
                                        int score = 0;
                                        print(scoreString);
                                        for (
                                          int i = 207;
                                          i < scoreString.length;
                                          i++
                                        ) {
                                          if (scoreString[i] == ')') {
                                            break;
                                          }
                                          score *= 10;
                                          score += int.parse(scoreString[i]);
                                        }
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => Results(
                                                  id: widget.id,
                                                  score: score,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Text("Принять"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  child: Icon(Icons.keyboard, size: 80),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
