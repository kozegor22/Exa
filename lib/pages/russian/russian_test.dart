import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/russian_dictations.dart';

class RussianTest extends StatefulWidget {
  const RussianTest({super.key, required this.id});
  final int id;

  @override
  State<RussianTest> createState() => _RussianTestState();
}

class _RussianTestState extends State<RussianTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(russianDictations[widget.id]![0].toString()),
      ),
      
    );
  }
}
