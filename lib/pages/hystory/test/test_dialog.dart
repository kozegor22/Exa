import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/hystory/test/test.dart';
TextEditingController input = TextEditingController();
class TestDialog extends StatefulWidget {
  const TestDialog({super.key});

  @override
  State<TestDialog> createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    setState(() {});
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Проверка"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(child: Text("Метод", style: TextStyle(fontSize: 30))),
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
                        } else if (int.parse(input.text) > 26) {
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
            MaterialPageRoute(builder: (context) => Test(id: id)),
          );
        }
      },
      child: Text("Выбрать билет самому"),
    );
  }

  TextButton byRandom(BuildContext context) {
    return TextButton(
      onPressed: () async {
        bool onelearned = false;
        for (int i = 1; i < 25; i++) {
          if (HystoryLearned.hystoryLearned[i] == true) {
            onelearned = true;
            break;
          }
        }
        if (onelearned == false) {
          await showDialog(
            context: context,
            builder:
                (builder) => AlertDialog(
                  title: Text("Ни один билет не изучен"),
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
                  title: Text("Билет будет выбран случайно из изученных"),
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
            if (HystoryLearned.hystoryLearned[id] == true) {
              break;
            }
          }
          id++;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Test(id: id)),
          );
        }
      },
      child: Text("Случайный"),
    );
  }
}
