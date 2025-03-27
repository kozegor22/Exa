import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';

class CompletedList extends StatefulWidget {
  const CompletedList({super.key});

  @override
  State<CompletedList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CompletedList> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Здесь можно проверить и отметить изученные билеты"),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: 25,
              itemBuilder:
                  (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((index + 1).toString()),
                      Transform.scale(
                        scale: 0.7,
                        child: Checkbox(
                          value: HystoryLearned.hystoryLearned[index],
                          onChanged: (state) {
                            setState(() {
                              HystoryLearned.hystoryLearned[index] = state ?? false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              HystoryLearned.saveLearned();
            },
            child: Text("Сохранить"),
          ),
        ],
      ),
    );
  }
}
