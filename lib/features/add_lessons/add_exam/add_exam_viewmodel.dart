import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/provs/exam_provider.dart';
import 'package:quiz_app/utils/models/question_model.dart';

class AddExamViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController optionAController = TextEditingController();
  final TextEditingController optionBController = TextEditingController();
  final TextEditingController optionCController = TextEditingController();
  final TextEditingController optionDController = TextEditingController();
  final TextEditingController passGradeController = TextEditingController();
  String? selectedOption;
  int currentQuestion = 0;
  
  final int amountOfQuestion = 9;

  List<QuestionModel> questionModels =
      List<QuestionModel>.filled(10, QuestionModel());

  bool isAllCheck = false;

  void onPressedSave(WidgetRef ref, BuildContext context) {
    if (formKey.currentState!.validate() && selectedOption != null) {
      // add model to list
      questionModels[currentQuestion] = QuestionModel(
        passGrade: int.parse(passGradeController.text),
        question: questionController.text,
        answers: [
          optionAController.text,
          optionBController.text,
          optionCController.text,
          optionDController.text
        ],
        correctAnswer: selectedOption!,
      );
      ref.read(isExamAddedProvider.notifier).setState(true);
      ref.read(examListProvider.notifier).saveList(questionModels);
      notifyListeners();
      Navigator.pop(context);
    }
    inspect(ref.read(examListProvider));
    print('exam prov: ${ref.read(isExamAddedProvider.notifier).state}');
  }

  void onPressedNextQuestion() {
    if (formKey.currentState!.validate() && selectedOption != null) {
      // add model to list
      questionModels[currentQuestion] = QuestionModel(
        passGrade: int.parse(passGradeController.text),
        question: questionController.text,
        answers: [
          optionAController.text,
          optionBController.text,
          optionCController.text,
          optionDController.text
        ],
        correctAnswer: selectedOption!,
      );

      currentQuestion++;

      if (questionModels[currentQuestion].question == null) {
        questionController.text = '';
        optionAController.text = '';
        optionBController.text = '';
        optionCController.text = '';
        optionDController.text = '';
        passGradeController.text = '';
        selectedOption = null;
      } else {
        questionController.text = questionModels[currentQuestion].question!;
        passGradeController.text =
            (questionModels[currentQuestion].passGrade!).toString();
        optionAController.text = questionModels[currentQuestion].answers![0];
        optionBController.text = questionModels[currentQuestion].answers![1];
        optionCController.text = questionModels[currentQuestion].answers![2];
        optionDController.text = questionModels[currentQuestion].answers![3];
        selectedOption = questionModels[currentQuestion].correctAnswer;
      }
      notifyListeners();
    }
  }

  void onPressedPreviousQuestion() {
    if (passGradeController.text.isEmpty) {
      passGradeController.text = '0';
    }
    questionModels[currentQuestion] = QuestionModel(
      question: questionController.text,
      passGrade: int.parse(passGradeController.text),
      answers: [
        optionAController.text,
        optionBController.text,
        optionCController.text,
        optionDController.text
      ],
      correctAnswer: selectedOption,
    );

    currentQuestion--;
    questionController.text = questionModels[currentQuestion].question!;
    passGradeController.text =
        (questionModels[currentQuestion].passGrade!).toString();
    optionAController.text = questionModels[currentQuestion].answers![0];
    optionBController.text = questionModels[currentQuestion].answers![1];
    optionCController.text = questionModels[currentQuestion].answers![2];
    optionDController.text = questionModels[currentQuestion].answers![3];
    selectedOption = questionModels[currentQuestion].correctAnswer;
    notifyListeners();
  }
}
