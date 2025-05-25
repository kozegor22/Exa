// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/data/debug_mode.dart';
import 'package:flutter_application_1/data/first_time.dart';
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
    DebugMode.load();
    FirstTime.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text("Настройки"),
          onLongPress: () {
            showDialog(
              context: context,
              builder:
                  (context2) => AlertDialog(
                    title: Text("Включить Дебаг режим?"),
                    content: Text(
                      "Режим предназначен для разработки и ни как для использования обычным пользователем",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context2);
                          setState(() {
                            DebugMode.save(true);
                            FirstTime.save(true);
                          });

                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text("Ура Дебаг"),
                                  content: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ок"),
                                  ),
                                ),
                          );
                        },
                        child: Text("Да!"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context2);
                        },
                        child: Text("Не не надо"),
                      ),
                    ],
                  ),
            );
          },
        ),
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
                    launchUrl(Uri.parse('https://github.com/kozegor22/Exa/tree/main'));
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
            if (DebugMode.debugmode)
              Column(//disable debug_mode
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        DebugMode.save(false);
                      });
                    },
                    child: Text("disable debug_mode"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
