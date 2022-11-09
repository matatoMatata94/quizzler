import 'package:flutter/material.dart';

import 'main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void resultDialog(bool win) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            win ? 'WINNER' : 'TRY AGAIN',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: win ? Colors.green : Colors.red,
      ),
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
                  questionBank.getQuestionText(),
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
                  setState(() {
                    if (questionBank.getQuestionNumber() ==
                        questionBank.getQuestionBankLength() - 1) {
                      questionBank.checkAnswer(true);
                      resultDialog(questionBank.getResult());
                    } else {
                      questionBank.checkAnswer(true);
                      questionBank.nextQuestion();
                    }
                  });
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
                  setState(() {
                    if (questionBank.getQuestionNumber() ==
                        questionBank.getQuestionBankLength() - 1) {
                      questionBank.checkAnswer(false);
                      resultDialog(questionBank.getResult());
                    } else {
                      questionBank.checkAnswer(false);
                      questionBank.nextQuestion();
                    }
                  });
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            child: Row(
              children: questionBank.userAnswers,
            ),
          ),
        ],
      ),
    );
  }
}
