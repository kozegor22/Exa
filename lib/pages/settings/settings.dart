// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/scripts/check_api_key.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        title: Text("Настройки"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              // Просмотреть API ключ
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ApiKey.load();
                    showDialog(
                      context: context,
                      builder:
                          (builder) => AlertDialog(
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
                  child: Text("Просмотреть API ключ"),
                ),
              ],
            ),
            Expanded(
              // Смена ключа
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      TextEditingController input = TextEditingController();
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text("Смена ключа"),
                              content: TextField(controller: input),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    if (!await checkApiKey(
                                      input.text,
                                      context,
                                    )) {
                                      setState(() {
                                        ApiKey.save(input.text);
                                      });
                                      showDialog(
                                        context: context,
                                        builder:
                                            (builder) => AlertDialog(
                                              title: Text(
                                                "Ключ успешно изменён",
                                              ),
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
                                  child: Text("Проверить и сохранить"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Отмена"),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Text("Сменить API ключ"),
                  ),
                ],
              ),
            ),
            Column(
              // Github link
              children: [
                ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://github.com'));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Icon(Icons.github),
                      Text("Project on GitHub"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
