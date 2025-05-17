// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/results/results.dart';
import 'package:flutter_application_1/pages/hystory/test/textanswer.dart';

class DebugMenu extends StatefulWidget {
  const DebugMenu({super.key});

  @override
  State<DebugMenu> createState() => _DebugMenuState();
}

class _DebugMenuState extends State<DebugMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("debug_menu", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'welcome_screen');
            },
            child: Text("welcome_screen"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextAnswer(id: 0)),
              );
            },
            child: Text("text_answer_hystory"),
          ),
          ElevatedButton(
            onPressed: () async {
              TextEditingController input = TextEditingController();
              TextEditingController input1 = TextEditingController();
              await showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text("options"),
                      content: Column(
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
                          },
                          child: Text("Ок"),
                        ),
                      ],
                    ),
              );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Results(
                          id: int.parse(input.text),
                          score: int.parse(input1.text),
                          inputType: false,
                          feedback: ["0", "Text"],
                        ),
                  ),
                );
              }
            },
            child: Text("results_hystory"),
          ),
        ],
      ),
    );
  }
}
