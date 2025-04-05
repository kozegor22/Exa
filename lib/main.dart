import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/data/first_time.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/hystory/learned_list.dart';
import 'package:flutter_application_1/pages/hystory/test/results.dart';
import 'package:flutter_application_1/pages/russian/russian_home.dart';
import 'package:flutter_application_1/pages/welcome_screen.dart';

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

Widget showWelcomeScreen() {
  if (FirstTime.firstTime) {
    return WelcomeScreen();
  }
  return Home();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    ApiKey.load;
    setState(() {});
    FirstTime.load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showWelcomeScreen(),
      routes: {
        'home': (context) => Home(),
        'learned_list': (context) => CompletedList(),
        'results_debug': (context) => Results(id: 1, score: 90),
        'russian_home': (context) => RussianHome(),
      },
    );
  }
}
