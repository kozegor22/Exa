import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/debug_mode.dart';
import 'package:flutter_application_1/pages/hystory/home/hystory_home.dart';
import 'package:flutter_application_1/pages/russian/russian_home.dart';

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
    setState(() {});
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
            if (DebugMode.debugmode)
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'debug_menu');
                },
                icon: Icon(Icons.android),
              ),
          ],
          automaticallyImplyLeading: false,
        ),

        /*bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: "История",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: "Русск. яз.",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: "Бел. яз.",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calculate),
            icon: Icon(Icons.calculate_outlined),
            label: "Математика",
          ),
        ],
      ),*/
        body:
            <Widget>[
              HystoryHome(),
              Column(children: [RussianHome()]),
              Column(children: [Text("$currentPageIndex")]),
              Column(children: [Text("$currentPageIndex")]),
            ][currentPageIndex],
      ),
    );
  }
}
