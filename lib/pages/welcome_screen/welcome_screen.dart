// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/first_time.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/scripts/check_api_key.dart';
import 'package:url_launcher/url_launcher.dart';

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
              /*Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ApiKey.save("zu-4d735eab2b2b0aa8c526974ba8c60e1f");
                      FirstTime.save(false);
                    });
                    Navigator.pushNamed(context, 'home');
                    Navigator.pushNamed(context, 'home');
                  },
                  child: Text("Debug continue"),
                ),
              ),*/
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String key = input.text;
                    if (key != "") {
                      if (!await checkApiKey(input.text, context)) {
                        setState(() {
                          ApiKey.save(input.text);
                          FirstTime.save(false);
                        });
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
