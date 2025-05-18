import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/debug_mode.dart';
import 'package:flutter_application_1/data/first_time.dart';
import 'package:flutter_application_1/pages/debug_menu/debug_menu.dart';
import 'package:flutter_application_1/pages/hystory/home/hystory_home.dart';
import 'package:flutter_application_1/pages/languages/languages_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    DebugMode.load();
    FirstTime.load();
    setState(() {});
  }

  Color debugcolor() {
    if (currentPageIndex == 4) {
      return Colors.black;
    }
    return Colors.blueAccent;
  }

  int inConstruction() {
    if (DebugMode.debugmode) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Домашняя")],
          ),
          backgroundColor: Colors.blueAccent,
          leading: null,

          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.pushNamed(context, 'settings');
                setState(() {});
              },
              icon: Icon(Icons.settings),
            ),
          ],
          automaticallyImplyLeading: false,
        ),

        bottomNavigationBar:
            <Widget>[
              Column(mainAxisSize: MainAxisSize.min),
              NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: Colors.blue,
                selectedIndex: currentPageIndex,
                destinations: <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(Icons.book),
                    icon: Icon(Icons.book_outlined),
                    label: "История",
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.book),
                    icon: Icon(Icons.book_outlined),
                    label: "Языки",
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.calculate),
                    icon: Icon(Icons.calculate_outlined),
                    label: "Математика",
                  ),
                  if (DebugMode.debugmode)
                    NavigationDestination(
                      selectedIcon: Icon(Icons.android),
                      icon: Icon(Icons.android_outlined),
                      label: "Debug_menu",
                    ),
                ],
              ),
            ][inConstruction()],
        body:
            <Widget>[
              HystoryHome(),
              LanguagesHome(),
              Column(children: [Text("$currentPageIndex")]),
              DebugMenu(),
              
            ][currentPageIndex],
      ),
    );
  }
}
