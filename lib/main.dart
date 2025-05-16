import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/data/first_time.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/debug_menu/debug_menu.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/hystory/learned_list.dart';
import 'package:flutter_application_1/pages/settings/settings.dart';
import 'package:flutter_application_1/pages/welcome_screen/welcome_screen.dart';

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
        'settings': (context) => Settings(),
        'debug_menu': (context) => DebugMenu(),
      },
    );
  }
}
