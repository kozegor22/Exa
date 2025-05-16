
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/scripts/history/check_answer.dart';

final TextEditingController input = TextEditingController();

class TextAnswer extends StatefulWidget {
  const TextAnswer({super.key, required this.id});
  final int id;
  @override
  State<TextAnswer> createState() => _TextAnswerState();
}

class _TextAnswerState extends State<TextAnswer> {
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
        title: Text("Текстовый ввод "),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: input,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ответ",
                ),
                expands: true,
                minLines: null,
                maxLines: null,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final answer = input.text;
              checkAnswer(answer, widget.id, context, ApiKey.apiKey, true);
            },
            child: Text("Проверить"),
          ),
        ],
      ),
    );
  }
}
