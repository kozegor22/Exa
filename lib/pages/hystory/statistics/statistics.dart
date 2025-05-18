import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_best_answers.dart';
import 'package:flutter_application_1/data/hystory_statistics.dart';
import 'package:flutter_application_1/pages/hystory/results/results.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  void initState() {
    super.initState();
    HystoryStatistics.load();
    HystoryBestAnswers.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Статистика по билетам"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 25,
              itemBuilder:
                  (context, index) => TextButton(
                    onPressed: () {
                      if (HystoryStatistics.hystoryStats[index] == -1) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text("Этот билет ещё не был проверен"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Понял"),
                                  ),
                                ],
                              ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Results(
                                  id: index,
                                  score: HystoryStatistics.hystoryStats[index],
                                  inputType: false,
                                  feedback:
                                      HystoryBestAnswers
                                          .hystoryBestAnswers[index],
                                ),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        if (HystoryStatistics.hystoryStats[index] > -1)
                          Text(
                            "Билет ${index + 1}:${HystoryStatistics.hystoryStats[index]}/100",
                            style: TextStyle(fontSize: 20),
                          )
                        else
                          Text(
                            "Билет ${index + 1}:Не проверен",
                            style: TextStyle(fontSize: 20),
                          ),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
