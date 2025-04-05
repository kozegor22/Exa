// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/pages/hystory/test/test.dart';
class TestRandom extends StatefulWidget {
  const TestRandom({super.key});

  @override
  State<TestRandom> createState() => _TestRandomState();
}

class _TestRandomState extends State<TestRandom> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () async {
        bool onelearned = false;
        for (int i = 1; i < 25; i++) {
          if (HystoryLearned.hystoryLearned[i] == true) {
            onelearned = true;
            break;
          }
        }
        if (onelearned == false) {
          await showDialog(
            context: context,
            builder:
                (builder) => AlertDialog(
                  title: Text("Ни один билет не изучен"),
                  content: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ок"),
                  ),
                ),
          );
        } else {
          await showDialog(
            context: context,
            builder:
                (builder) => AlertDialog(
                  title: Text("Билет будет выбран случайно из изученных"),
                  content: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ок"),
                  ),
                ),
          );
          int id;
          while (true) {
            id = Random().nextInt(25);
            if (HystoryLearned.hystoryLearned[id] == true) {
              break;
            }
          }
          id++;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Test(id: id)),
          );
        }
      }, child: Text("Случайный"));
  }
}