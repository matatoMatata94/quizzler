import 'package:flutter/material.dart';

import 'question.dart';

class QuizBrain {
  late int _questionNumber = 0;
  int counterRightAnswers = 0;
  int counterWrongAnswers = 0;

  Icon right = const Icon(Icons.check, color: Colors.green);
  Icon wrong = const Icon(Icons.close, color: Colors.red);

  List<Icon> userAnswers = [];

  final List<Question> _questions = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was "Moon".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called "Backrub".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  String getQuestionText() {
    return _questions[_questionNumber].questionText;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  bool getQuestionAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  int getQuestionBankLength() {
    return _questions.length;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  void checkAnswer(bool userAnswer) {
    if (_questions[_questionNumber].questionAnswer == userAnswer) {
      userAnswers.add(right);
      counterRightAnswers++;
    } else {
      userAnswers.add(wrong);
      counterWrongAnswers++;
    }
  }

  bool isFinished() {
    if (getQuestionNumber() == getQuestionBankLength() - 1) {
      return true;
    } else {
      return false;
    }
  }

  void clearAnswers() {
    userAnswers = [];
  }

  bool getResult() {
    if (counterRightAnswers > counterWrongAnswers) {
      _questionNumber = 0;
      counterRightAnswers = 0;
      counterWrongAnswers = 0;
      return true;
    } else {
      _questionNumber = 0;
      counterRightAnswers = 0;
      counterWrongAnswers = 0;

      return false;
    }
  }
}
