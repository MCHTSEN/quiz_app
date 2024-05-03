import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:quiz_app/features/add_lessons/add_exam_sheet.dart';
import 'package:quiz_app/features/add_lessons/add_exam/add_exam_view.dart';
import 'package:quiz_app/features/add_lessons/add_lessons_viewmodel.dart';
import 'package:quiz_app/utils/enums/custom_borders.dart';
import 'package:quiz_app/utils/validators/quiz_validators.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddLessonsView extends ConsumerStatefulWidget {
  const AddLessonsView({Key? key}) : super(key: key);

  @override
  _AddLessonsViewState createState() => _AddLessonsViewState();
}

class _AddLessonsViewState extends ConsumerState<AddLessonsView> {
  final AddLessonsViewModel _viewModel = AddLessonsViewModel();
  final _formKey = GlobalKey<FormState>();
  List<String>? currentKonuBasliklari;

  String? _selectedOption;
  String? _selectedSubtitle;
  final TextEditingController _videoURLController = TextEditingController();
  final TextEditingController _lessonDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _videoURLController.dispose();
    _lessonDescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentKonuBasliklari = _viewModel.matematikKonuBasliklari;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ders Ekle',
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _pickLesson(),
                  Gap(2.h),
                  _pickSubtitle(),
                  Gap(2.h),
                  _enterUrl(),
                  Gap(2.h),
                  _enterDescription(),
                  Gap(3.h),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: const AddExamView());
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Sinav Ekle'),
                  ),
                  Gap(3.h),
                  ElevatedButton.icon(
                    onPressed:  () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form Gönderildi')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _enterDescription() {
    return TextFormField(
      controller: _lessonDescriptionController, // Controller'ı atayın
      maxLines: 5,
      validator: QuizValidators().cannotNull,
      decoration: InputDecoration(
        labelText: 'Ders Açıklaması',
        border: OutlineInputBorder(
          borderRadius: CustomBorders.highBorderRadius.getBorderRadius(),
        ),
      ),
    );
  }

  TextFormField _enterUrl() {
    return TextFormField(
      controller: _videoURLController,
      validator: QuizValidators().cannotNull,
      decoration: InputDecoration(
        suffix: IconButton(
            onPressed: () async {
              ClipboardData? clipboardData =
                  await Clipboard.getData(Clipboard.kTextPlain);
              if (clipboardData != null) {
                _videoURLController.text = clipboardData.text ?? 'asd';
              }
            },
            icon: const Icon(Icons.paste)),
        labelText: "Ders Video URL'si ",
        border: OutlineInputBorder(
          borderRadius: CustomBorders.highBorderRadius.getBorderRadius(),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _pickLesson() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Ders Seçiniz',
        border: OutlineInputBorder(),
      ),
      value: _selectedOption,
      onChanged: (String? newValue) {
        _selectedSubtitle = null;

        setState(() {
          if (newValue != null) {
            _selectedOption = newValue;
            currentKonuBasliklari = newValue == 'Fizik'
                ? _viewModel.fizikKonuBasliklari
                : _viewModel.matematikKonuBasliklari;
          }
        });
      },
      validator: QuizValidators().cannotNull,
      items: <String>['Fizik', 'Matematik'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  DropdownButtonFormField<String> _pickSubtitle() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Ders Seçiniz',
        border: OutlineInputBorder(),
      ),
      value: _selectedSubtitle,
      onChanged: (String? newValue) {
        setState(() {
          if (newValue != null) {
            _selectedSubtitle = newValue;
          }
        });
      },
      validator: QuizValidators().cannotNull,
      items: currentKonuBasliklari!.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
