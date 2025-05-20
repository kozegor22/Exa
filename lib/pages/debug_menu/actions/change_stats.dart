import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_statistics.dart';

class ChangeStats extends StatelessWidget {
  const ChangeStats({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: () async {
            TextEditingController input = TextEditingController();
            TextEditingController input1 = TextEditingController();
            await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text("options"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: input,
                          decoration: InputDecoration(hint: Text("id")),
                        ),
                        TextField(
                          controller: input1,
                          decoration: InputDecoration(hint: Text("score")),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (input.text == "" || input1.text == "") {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text("null value"),
                                    content: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ок"),
                                    ),
                                  ),
                            );
                          } else {
                              HystoryStatistics.hystoryStats[int.parse(
                                input.text,
                              )] = int.parse(input1.text);
                            HystoryStatistics.save();
                          }
                        },
                        child: Text("Ок"),
                      ),
                    ],
                  ),
            );
          },
          child: Text("change_stats"),
        );
  }
}