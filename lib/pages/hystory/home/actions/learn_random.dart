// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/hystory/learn/learn.dart';
import 'dart:math';
import 'package:flutter_application_1/data/hystory_learned.dart';
class LearnRandom extends StatefulWidget {
  const LearnRandom({super.key});

  @override
  State<LearnRandom> createState() => _LearnRandomState();
}

class _LearnRandomState extends State<LearnRandom> {
  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () async {
        bool alllearned = true;
        for (int i = 0; i < 25; i++) {
          if (HystoryLearned.hystoryLearned[i] == false) {
            alllearned = false;
            break;
          }
        }
        if (alllearned == true) {
          await showDialog(
            context: context,
            builder:
                (builder) => AlertDialog(
                  title: Text("Все билеты изучены"),
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
                  title: Text("Билет будет выбран случайно из неизученных"),
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
            if (HystoryLearned.hystoryLearned[id] == false) {
              break;
            }
          }
          id++;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Learn(id: id)),
          );
        }
      }, child: Text("Случайный"));
  }
}