import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:quiz_app/features/add_lessons/add_exam/add_exam_viewmodel.dart';
import 'package:quiz_app/provs/exam_provider.dart';
import 'package:quiz_app/utils/validators/quiz_validators.dart';
import 'package:quiz_app/utils/widgets/answer_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddExamView extends ConsumerStatefulWidget {
  const AddExamView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddExamViewState();
}

class _AddExamViewState extends ConsumerState<AddExamView> {
  final AddExamViewModel _viewModel = AddExamViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Form(
          key: _viewModel.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // gap(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _questionNumber(context),
                    IconButton(
                        onPressed: () {
                          ref
                              .read(isExamAddedProvider.notifier)
                              .setState(false);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                halfGap(),
                TextFormField(
                  validator: QuizValidators().cannotNull,
                  controller: _viewModel.questionController,
                  decoration: const InputDecoration(
                    label: Text('Sorunuzu girin'),
                  ),
                ),
                halfGap(),
                const Divider(),
                halfGap(),
                _textAnswers(context),
                lowGap(),
                AnswerWidget(
                  option: 'A',
                  controller: _viewModel.optionAController,
                ),
                lowGap(),
                AnswerWidget(
                  option: 'B',
                  controller: _viewModel.optionBController,
                ),
                lowGap(),
                AnswerWidget(
                  option: 'C',
                  controller: _viewModel.optionCController,
                ),
                lowGap(),
                AnswerWidget(
                  option: 'D',
                  controller: _viewModel.optionDController,
                ),
                halfGap(),
                _selectAnswer(context),
                halfGap(),
                if (_viewModel.currentQuestion == 0)
                  TextFormField(
                    controller: _viewModel.passGradeController,
                    validator: QuizValidators().cannotNull,
                    decoration: const InputDecoration(
                      suffix: Text(
                        '/100',
                        style: TextStyle(fontSize: 20),
                      ),
                      label: Text('Geçme Notu Giriniz'),
                    ),
                  ),
                Column(
                  children: [
                    Row(mainAxisSize: MainAxisSize.max, children: [
                      if (_viewModel.currentQuestion != 0)
                        Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                                onPressed: _viewModel.onPressedPreviousQuestion,
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Onceki Soru'))),
                      const Spacer(),
                      if (_viewModel.currentQuestion !=
                          _viewModel.amountOfQuestion)
                        ElevatedButton.icon(
                            onPressed: _viewModel.onPressedNextQuestion,
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('Sonraki Soru')),
                    ]),
                    if (_viewModel.currentQuestion ==
                        _viewModel.amountOfQuestion)
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                _viewModel.onPressedSave(ref, context);
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Kaydet'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _textAnswers(BuildContext context) {
    return Text('Cevaplar',
        style: context.general.textTheme.headlineSmall!.copyWith(
          color: Colors.black,
        ));
  }

  Container _selectAnswer(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          const Text(
            'Doğru Şıkkı Seçin ',
            style: TextStyle(fontSize: 18),
          ),
          halfGap(),
          DropdownButton<String>(
            hint: Text('Seçin',
                style: context.general.textTheme.headlineSmall!
                    .copyWith(color: Colors.black, fontSize: 18)),
            value: _viewModel.selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                _viewModel.selectedOption = newValue;
              });
            },
            items: ['A', 'B', 'C', 'D']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  gap() => Gap(5.h);
  halfGap() => Gap(2.5.h);
  lowGap() => Gap(1.h);

  RichText _questionNumber(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Soru  ',
          style: context.general.textTheme.headlineSmall!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
      TextSpan(
          text: (_viewModel.currentQuestion + 1).toString(),
          style: context.general.textTheme.headlineLarge!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w600)),
    ]));
  }
}
