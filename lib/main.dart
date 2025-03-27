import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/hystory/completed_list.dart';
import 'package:flutter_application_1/pages/hystory/hystory_home.dart';
import 'package:flutter_application_1/pages/hystory/learn/learn_dialog.dart';
import 'package:flutter_application_1/pages/hystory/test/results.dart';
import 'package:flutter_application_1/pages/hystory/test/test_dialog.dart';
import 'package:flutter_application_1/pages/russian/russian_home.dart';

void main() {
  runApp(const MyApp());
  ApiKey.load;
  HystoryLearned.loadLearned();

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    ApiKey.load;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        'completed_list': (context) => CompletedList(),
        'learn_dialog': (context) => LearnDialog(),
        'test_dialog': (context) => TestDialog(),
        'results_debug': (context) => Results(id: 1, score: 90),
        'hystory_home': (context) => HystoryHome(),
        'russian_home': (context) => RussianHome(),
      },
    );
  }
}
