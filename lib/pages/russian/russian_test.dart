// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/russian_dictations.dart';
import 'package:flutter_tts/flutter_tts.dart';

int dictTimes = 0;
final FlutterTts flutterTts = FlutterTts();

class RussianTest extends StatefulWidget {
  const RussianTest({super.key, required this.id});
  final int id;

  @override
  State<RussianTest> createState() => _RussianTestState();
}

class _RussianTestState extends State<RussianTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      russianDictations[widget.id]![0],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(child: Text("Диктовка №$dictTimes")),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await flutterTts.setLanguage("ru-RU");
                  await flutterTts.setVolume(1.0);
                  if (dictTimes == 0) {
                    await flutterTts.setSpeechRate(1.0);
                  } else {
                    await flutterTts.setSpeechRate(1.0);
                  }
                  await flutterTts.setPitch(1.0);
                  await flutterTts.speak(
                    russianDictations[widget.id]![1],
                    focus: true,
                  );
                  dictTimes++;
                  if (dictTimes == 3) {}
                  setState(() {});
                },
                child: Icon(Icons.mic, size: 100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
