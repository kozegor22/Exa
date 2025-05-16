// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/scripts/history/check_answer.dart';
import 'package:flutter_application_1/pages/hystory/test/textanswer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

TextEditingController input = TextEditingController();
String answer = "";

bool recording = false;
stt.SpeechToText _speech = stt.SpeechToText();
String recognizedText = "";

class Test extends StatefulWidget {
  const Test({super.key, required this.id});
  final int id;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

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
        title: Text("Проверка билет №${widget.id}"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            bool sure = false;
            await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text("Сдаться?"),
                    content: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Нет"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            sure = true;
                          },
                          child: Text("Да"),
                        ),
                      ],
                    ),
                  ),
            );
            if (sure == true) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Поведай мне ответ")),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (!recording) {
                      bool available = await _speech.initialize().catchError((
                        error,
                      ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Преобразование речи в тeкст не поддерживается на твоём устройстве :(",
                            ),
                          ),
                        );
                        return false;
                      });
                      if (available) {
                        setState(() {
                          recording = true;
                        });
                        _speech.listen(
                          localeId: "ru-RU",
                          onResult: (result) {
                            if (mounted) {
                              setState(() {
                                recognizedText = result.recognizedWords;
                              });
                            }
                          },
                        );
                      }
                    } else {
                      _speech.stop();
                      setState(() {
                        recording = false;
                        ApiKey.load;
                      });
                      checkAnswer(
                        recognizedText,
                        widget.id,
                        context,
                        ApiKey.apiKey,
                        false
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Icon(recording ? Icons.stop : Icons.mic, size: 100),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TextAnswer(id: widget.id),
                      ),
                    );
                    
                  },
                  child: Icon(Icons.keyboard, size: 80),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
