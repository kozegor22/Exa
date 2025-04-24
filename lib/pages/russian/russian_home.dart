import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/russian_dictations.dart';
import 'package:flutter_application_1/pages/russian/russian_test.dart';

TextEditingController input = TextEditingController();

class RussianHome extends StatelessWidget {
  const RussianHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                              id = Random().nextInt(russianDictations.length-1)+1;
                            }
                            id = int.parse(input.text);
                            if (id <= 0 || id > russianDictations.length) {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("Такого диктанта нет"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ок"),
                                        ),
                                      ],
                                    ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RussianTest(id: id),
                                ),
                              );
                            }
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
        TextButton(
          onPressed: () {
            final id = Random().nextInt(russianDictations.length-1)+1;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RussianTest(id: id)),
            );
          },
          child: Text("Случайный"),
        ),
      ],
    );
  }
}
