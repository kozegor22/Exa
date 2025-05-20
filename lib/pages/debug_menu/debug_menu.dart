// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hystory_statistics.dart';
import 'package:flutter_application_1/pages/debug_menu/actions/change_stats.dart';
import 'package:flutter_application_1/pages/debug_menu/actions/fake_check_ans.dart';
import 'package:flutter_application_1/pages/debug_menu/actions/fake_results_hystory.dart';
import 'package:flutter_application_1/pages/debug_menu/actions/go_to_welcome_screen.dart';

class DebugMenu extends StatefulWidget {
  const DebugMenu({super.key});

  @override
  State<DebugMenu> createState() => _DebugMenuState();
}

class _DebugMenuState extends State<DebugMenu> {
  @override
  void initState() {
    super.initState();
    HystoryStatistics.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GoToWelcomeScreen(),
        Fakeresultshystory(),
        ChangeStats(),
        Fakecheckans()
      ],
    );
  }
}
