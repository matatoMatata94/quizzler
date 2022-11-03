import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';

void main() => runApp(const Quizzler());

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
  int questionCounter = 0;

  final List<Question> questions = [
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    Question(q: 'A slug\'s blood is green.', a: true),
    Question(
        q: 'Approximately one quarter of human bones are in the feet.',
        a: false),
  ];

  List<Icon> answers = [];

  Icon right = const Icon(Icons.check, color: Colors.green);
  Icon wrong = const Icon(Icons.close, color: Colors.red);

  void checkAnswer(Question question, bool userAnswer) {
    if (question.questionAnswer == userAnswer) {
      answers.add(right);
    } else {
      answers.add(wrong);
    }
  }

  void setQuestionCounter() {
    setState(() {
      if (questionCounter < questions.length - 1) {
        setState(() {
          questionCounter++;
        });
      } else {
        setState(() {
          questionCounter = 0;
        });
      }
    });
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
                  questions[questionCounter].questionText,
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
                  checkAnswer(questions[questionCounter], true);
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
                  checkAnswer(questions[questionCounter], false);
                  setQuestionCounter();
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            child: Row(
              children: answers,
            ),
          ),
        ],
      ),
    );
  }
}
