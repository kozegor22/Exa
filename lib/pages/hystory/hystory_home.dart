// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/hystorydrawer.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchURL() async {
  Uri _url = Uri.parse('https://discord.gg/zukijourney');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}

class HystoryHome extends StatelessWidget {
  HystoryHome({super.key});

  final TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('История'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: HystoryDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("Привет путник", style: TextStyle(fontSize: 30)),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Это приложение поможет тебе подготовиться к экзамену по истории",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "Но приложение использует zukijourney API так что тебе придётся зайти в их дискорд канал и ввести свой ключ",
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextButton(onPressed: _launchURL, child: Text('Перейти на сервер')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: input,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "API ключ",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (input.text == "") {
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
                  } else {
                    ApiKey.save(input.text);
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Ключ успешно сохранён"),
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
                child: Text("Сохранить"),
              ),
              TextButton(
                onPressed: () async {
                  ApiKey.load();
                  await showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(ApiKey.apiKey),
                          content: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ок"),
                          ),
                        ),
                  );
                },
                child: Text("Посмотреть ключ"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
