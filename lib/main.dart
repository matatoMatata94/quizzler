import 'package:flutter/material.dart';

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

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;

  int counterRightAnswers = 0;
  int counterWrongAnswers = 0;

  List<Icon> userAnswers = [];

  Icon right = const Icon(Icons.check, color: Colors.green);
  Icon wrong = const Icon(Icons.close, color: Colors.red);

  void checkAnswer(int questionNumber, bool userAnswer) {
    if (questionBank.getQuestionAnswer(questionNumber) == userAnswer) {
      userAnswers.add(right);
      counterRightAnswers++;
    } else {
      userAnswers.add(wrong);
      counterWrongAnswers++;
    }
  }

  void setQuestionCounter() {
    setState(
      () {
        if (questionNumber < questionBank.getQuestionBankLength() - 1) {
          setState(() {
            questionNumber++;
          });
        } else {
          setState(
            () {
              questionNumber = 0;
              userAnswers.clear();
              if (counterRightAnswers > counterWrongAnswers) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Center(
                      child: Text(
                        'WINNER',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Center(
                      child: Text(
                        'TRY AGAIN',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questionBank.getQuestionText(questionNumber),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(
                textColor: Colors.white,
                color: Colors.green,
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(questionNumber, true);
                  setQuestionCounter();
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(
                color: Colors.red,
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(questionNumber, false);
                  setQuestionCounter();
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            child: Row(
              children: userAnswers,
            ),
          ),
        ],
      ),
    );
  }
}
