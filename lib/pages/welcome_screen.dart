// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/first_time.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dart_openai/dart_openai.dart';

Future<void> launchURL() async {
  Uri url = Uri.parse('https://discord.gg/zukijourney');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Не получилось зайти на $url';
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    FirstTime.load();
    ApiKey.load();
    setState(() {});
  }

  String key = ApiKey.apiKey;
  final TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Привет!"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Я приложение помощник и помогу подготовиться тебу к экзаменам\n"
                    "Но приложение использует ZukijourneyAPI для обработки ответов\n"
                    "Который тебе придётся взять в их дискорде во вкладке Info_panels\n",
                    style: TextStyle(fontSize: 20, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                launchURL();
              },
              child: Text("Перейти в ДС"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: input,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "API ключ",
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    FirstTime.save(false);
                    Navigator.pushNamed(context, 'home');
                  },
                  child: Text("Debug continue"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool requestFailed = false;
                    String key = input.text;
                    if (key != "") {
                      OpenAI.baseUrl = "https://api.zukijourney.com";
                      OpenAI.apiKey = key;
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
                          requestFailed = true;
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text("Неверный ключ"),
                                  content: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ок"),
                                  ),
                                ),
                          );
                        } else {
                          requestFailed = true;
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
                      if (!requestFailed) {
                        FirstTime.save(false);
                        Navigator.pushNamed(context, 'home');
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text("Введи ключ"),
                              content: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Ок"),
                              ),
                            ),
                      );
                    }
                  },
                  child: Text("Сохранить и продолжить"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
