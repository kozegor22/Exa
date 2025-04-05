// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/hystory/learn/learn.dart';
TextEditingController input = TextEditingController();
class LearnMyself extends StatelessWidget {
  const LearnMyself({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () async {
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
      }, child: Text("Выбрать самому"));
  }
}