import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apikey.dart';
import 'package:flutter_application_1/data/first_time.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/debug_menu/debug_menu.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/hystory/last_answers/hystory_last_answers_page.dart';
import 'package:flutter_application_1/pages/hystory/learned_list.dart';
import 'package:flutter_application_1/pages/settings/settings.dart';
import 'package:flutter_application_1/pages/welcome_screen/welcome_screen.dart';

void main() {
  runApp(const MyApp());
  ApiKey.load;
  HystoryLearned.loadLearned();
  FirstTime.load();
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget showWelcomeScreen(bool firstTime) {
    if (firstTime) {
      return WelcomeScreen();
    }
    return Home();
  }

  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    ApiKey.load;
    FirstTime.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: showWelcomeScreen(FirstTime.firstTime),
      routes: {
        'home': (context) => Home(),
        'learned_list': (context) => CompletedList(),
        'settings': (context) => Settings(),
        'debug_menu': (context) => DebugMenu(),
        'welcome_screen': (context) => WelcomeScreen(),
        'hystory_last_answers_page': (context) => HystoryLastAnswersPage(),
      },
    );
  }
}
