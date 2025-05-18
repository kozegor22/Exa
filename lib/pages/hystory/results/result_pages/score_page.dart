import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_learned.dart';
import 'package:flutter_application_1/data/hystory_statistics.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.score, required this.id});
  final int score;
  final int id;
  @override
  State<ScorePage> createState() => _ScorePageState();
}

late int clicks;

class _ScorePageState extends State<ScorePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String grade(int score, id) {
    setState(() {
      HystoryStatistics.hystoryStats[id] == score;
      HystoryStatistics.save();
    });
    if (score >= 85) {
      setState(() {
        HystoryLearned.hystoryLearned[id] == true;
        HystoryLearned.saveLearned();
      });
      return "Замечательно ^_^";
    } else if (score >= 75 && score <= 84) {
      setState(() {
        HystoryLearned.hystoryLearned[id] == true;
        HystoryLearned.saveLearned();
      });
      return "Хорошо :)";
    } else if (score >= 55 && score <= 74) {
      return "Надо подучить -_-";
    }
    return "Плохо :(";
  }

  @override
  void initState() {
    super.initState();
    HystoryLearned.loadLearned();
    HystoryStatistics.load();
    clicks = 0;
    _controller = AnimationController(
      duration: const Duration(minutes: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            grade(widget.score, widget.id),
            style: TextStyle(fontSize: 30),
          ),
        ),
        Center(
          child: Text("${widget.score}/100", style: TextStyle(fontSize: 40)),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 20 * math.pi,
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  clicks += 1;
                  if (clicks % 20 == 0) {
                    launchUrl(
                      Uri.parse(
                        'https://youtu.be/dQw4w9WgXcQ?si=jPr_fDWEO45v8nhv',
                      ),
                    );
                  }
                });
              },
              child: FlutterLogo(size: 200),
            ),
          ),
        ),
      ],
    );
  }
}
