// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/data/tickets.dart';
import 'package:flutter_application_1/pages/hystory/test/test.dart';

class Learn extends StatefulWidget {
  const Learn({super.key, required this.id});
  final int id;

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Билет ${widget.id}"),
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
          Expanded(child: ListView(children: [Text("${tickets[widget.id]}")])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    HystoryLearned.hystoryLearned[widget.id - 1] = true;
                    HystoryLearned.saveLearned();
                    Navigator.pop(context);
                  },
                  child: Text("Изучил"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Test(id: widget.id),
                      ),
                    );
                  },
                  child: Text("Проверить"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
