import 'package:flutter/material.dart';

class HowItWorks extends StatefulWidget {
  const HowItWorks({super.key});

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (builder) => AlertDialog(
                title: Text("Как это работает?"),
                content: Text(
                  "Твой ответ обрабатывается ИИ от zukijourney и он даёт свою оценку и комментарий, как от учителя, (он старается).\nКоличество запросов примерно ограничено 21, так что думай перед отпракой ответа!",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(builder);
                    },
                    child: Text("Понял"),
                  ),
                ],
              ),
        );
      },
      child: Text("Как это работает?"),
    );
  }
}
