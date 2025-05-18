import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/go_to_learned_list.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/go_to_stats.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/how_it_works.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/learn_myself.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/learn_random.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/test_myself.dart';
import 'package:flutter_application_1/pages/hystory/home/actions/test_random.dart';

class HystoryHome extends StatelessWidget {
  const HystoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Изучение билетов:",
            style: TextStyle(fontSize: 30, height: 1.4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(children: [LearnMyself(), LearnRandom()]),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Проверка:", style: TextStyle(fontSize: 30, height: 1.4)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(children: [TestMyself(), TestRandom()]),
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: GoToLearnedList()),
        Padding(padding: const EdgeInsets.only(left: 8.0),child: GoToStats(),),
        Padding(
          padding: const EdgeInsets.all( 8.0),
          child: HowItWorks(),
        ),
      ],
    );
  }
}
