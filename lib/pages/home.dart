import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Домашняя")],
        ),
        backgroundColor: Colors.blueAccent,
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
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
      ),

      body:
          <Widget>[
            HystoryHome(),
            Column(children: [RussianHome()]),
            Column(children: [Text("$currentPageIndex")]),
            Column(children: [Text("$currentPageIndex")]),
          ][currentPageIndex],
    );
  }
}
