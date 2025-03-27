import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/russian_dictations.dart';
import 'package:flutter_application_1/pages/russian/russian_test.dart';

TextEditingController input = TextEditingController();

class RussianHome extends StatefulWidget {
  const RussianHome({super.key});

  @override
  State<RussianHome> createState() => _RussianHomeState();
}

class _RussianHomeState extends State<RussianHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Русский язык"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Приложение продиктует и проверит изложение",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text("Номер диктанта"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: input,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  int id;
                                  if (input.text == "") {
                                    id = Random().nextInt(russianDictations.length);
                                  }
                                  id = int.parse(input.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RussianTest(id: id),
                                    ),
                                  );
                                },
                                child: Text("Выбрать"),
                              ),
                            ],
                          ),
                        ),
                  );
                },
                child: Text("Выбрать самому"),
              ),
              TextButton(onPressed: () {}, child: Text("Случайный")),
            ],
          ),
        ],
      ),
    );
  }
}
