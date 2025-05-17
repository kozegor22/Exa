import 'package:flutter/material.dart';

class AiFeedback extends StatefulWidget {
  const AiFeedback({super.key, required this.feedback});
  final List<String> feedback;
  @override
  State<AiFeedback> createState() => _AiFeedbackState();
}

class _AiFeedbackState extends State<AiFeedback> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.feedback.length - 1,
            itemBuilder:
                (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.feedback[index + 1],
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ],
    );
  }
}
