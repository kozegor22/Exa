import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/statistics/statistics.dart';

class GoToStats extends StatefulWidget {
  const GoToStats({super.key});

  @override
  State<GoToStats> createState() => _GoToStatsState();
}

class _GoToStatsState extends State<GoToStats> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Statistics()),
        );
      },
      child: Text("Статистика"),
    );
  }
}
