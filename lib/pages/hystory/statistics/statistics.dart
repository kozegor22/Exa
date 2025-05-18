import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_statistics.dart';

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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: 25,
              itemBuilder:
                  (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (HystoryStatistics.hystoryStats[index] > -1)
                        Text(
                          "${index + 1}:${HystoryStatistics.hystoryStats[index]}/100",
                        )
                      else
                        Text("${index + 1}:Не проверен"),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
