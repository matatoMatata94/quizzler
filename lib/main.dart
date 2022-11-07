import 'package:flutter/material.dart';
import 'package:quizzler/quiz_page.dart';

import 'quiz_brain.dart';

void main() => runApp(const Quizzler());

QuizBrain questionBank = QuizBrain();

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}
