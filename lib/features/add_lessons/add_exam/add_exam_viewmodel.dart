import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/utils/models/question_model.dart';

class AddExamViewModel extends ChangeNotifier {
  String? selectedOption;
  int currentQuestion = 0;
  List<QuestionModel> questionModels =
      List<QuestionModel>.filled(10, QuestionModel());

  bool isAllCheck = false;

  final int amountOfQuestion = 2;
  void onPressedNextQuestion() {
    if (formKey.currentState!.validate() && selectedOption != null) {
      questionModels[currentQuestion] = QuestionModel(
        question: questionController.text,
        answers: [
          optionAController.text,
          optionBController.text,
          optionCController.text,
          optionDController.text
        ],
        correctAnswer: selectedOption!,
      );

      inspect(questionModels);
      currentQuestion++;
      questionController.text = '';
      optionAController.text = '';
      optionBController.text = '';
      optionCController.text = '';
      optionDController.text = '';
      selectedOption = null;
      // questionController.text = questionModels[currentQuestion].question ?? '';
      // optionAController.text = questionModels[currentQuestion].answers![0];
      // optionBController.text = questionModels[currentQuestion].answers![1];
      // optionCController.text = questionModels[currentQuestion].answers![2];
      // optionDController.text = questionModels[currentQuestion].answers![3];
      // selectedOption = null;
      // selectedOption = questionModels[currentQuestion].correctAnswer;
      notifyListeners();
    }
  }

  void onPressedPreviousQuestion() {
    currentQuestion--;
    questionController.text = questionModels[currentQuestion].question!;
    optionAController.text = questionModels[currentQuestion].answers![0];
    optionBController.text = questionModels[currentQuestion].answers![1];
    optionCController.text = questionModels[currentQuestion].answers![2];
    optionDController.text = questionModels[currentQuestion].answers![3];
    selectedOption = questionModels[currentQuestion].correctAnswer;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController optionAController = TextEditingController();
  final TextEditingController optionBController = TextEditingController();
  final TextEditingController optionCController = TextEditingController();
  final TextEditingController optionDController = TextEditingController();
}
