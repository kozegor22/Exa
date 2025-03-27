// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/hystory/learn/learn.dart';

TextEditingController input = TextEditingController();

class LearnDialog extends StatefulWidget {
  const LearnDialog({super.key});

  @override
  State<LearnDialog> createState() => _LearnDialogState();
}

class _LearnDialogState extends State<LearnDialog> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Учить"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Выбери способ",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [myself(context), byRandom(context)],
            ),
          ),
        ],
      ),
    );
  }

  TextButton byRandom(BuildContext context) {
    return TextButton(
      onPressed: () async {
        bool alllearned = true;
        for (int i = 1; i < 26; i++) {
          if (HystoryLearned.hystoryLearned[i] == false) {
            alllearned = false;
            break;
          }
        }
        if (alllearned == true) {
          await showDialog(
            context: context,
            builder:
                (builder) => AlertDialog(
                  title: Text("Все билеты изучены"),
                  content: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ок"),
                  ),
                ),
          );
        } else {
          await showDialog(
            context: context,
            builder:
                (builder) => AlertDialog(
                  title: Text("Билет будет выбран случайно из неизученных"),
                  content: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ок"),
                  ),
                ),
          );
          int id;
          while (true) {
            id = Random().nextInt(25);
            if (HystoryLearned.hystoryLearned[id] == false) {
              break;
            }
          }
          id++;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Learn(id: id)),
          );
        }
      },
      child: Text("Случайный"),
    );
  }

  TextButton myself(BuildContext context) {
    return TextButton(
      onPressed: () async {
        int id = 26;
        bool selected = true;
        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("Номер билета"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: input,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextButton(
                      onPressed: () {
                        if (input.text == "") {
                          Navigator.pop(context);
                          selected = false;
                          showDialog(
                            context: context,
                            builder:
                                (builder) => AlertDialog(
                                  title: Text("Выбери билет"),
                                  content: TextButton(
                                    onPressed: () {
                                      Navigator.pop(builder);
                                    },
                                    child: Text("Я исправлюсь"),
                                  ),
                                ),
                          );
                        } else if (int.parse(input.text) > 25) {
                          Navigator.pop(context);
                          selected = false;
                          showDialog(
                            context: context,
                            builder:
                                (builder) => AlertDialog(
                                  title: Text("Выбран неверный билет"),
                                  content: TextButton(
                                    onPressed: () {
                                      Navigator.pop(builder);
                                    },
                                    child: Text("Я исправлюсь"),
                                  ),
                                ),
                          );
                        } else {
                          id = int.parse(input.text);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Принять"),
                    ),
                  ],
                ),
              ),
        );
        if (selected) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Learn(id: id)),
          );
        }
      },
      child: Text("Выбрать билет самому"),
    );
  }
}
