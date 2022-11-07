import 'package:flutter/material.dart';

import 'main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
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
    if (questionNumber < questionBank.getQuestionBankLength() - 1) {
      setState(() {
        questionNumber++;
      });
    } else {
      setState(
        () {
          questionNumber = 0;
          userAnswers.clear();

          //TODO: Show points
          if (counterRightAnswers > counterWrongAnswers) {
            showDialog(
              context: context,
              //win
              builder: (context) => resultDialog(true),
            );
          } else {
            showDialog(
                context: context,
                //lose
                builder: (context) => resultDialog(false));
          }
        },
      );
    }
  }

  AlertDialog resultDialog(bool win) {
    return AlertDialog(
      title: Center(
        child: Text(
          win ? 'WINNER' : 'TRY AGAIN',
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.green,
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
