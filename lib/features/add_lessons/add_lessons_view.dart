import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app/utils/validators/quiz_validators.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddLessonsView extends ConsumerStatefulWidget {
  const AddLessonsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddLessonsViewState();
}

class _AddLessonsViewState extends ConsumerState<AddLessonsView> {
  final _formKey = GlobalKey<FormState>();
  String _selectedOption = 'Fizik';
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
            icon: const Icon(Icons.chevron_left)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Ders Seçiniz',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null) {
                        _selectedOption = newValue;
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
                ),
                Gap(2.h),
                // Ders Video URL'si
                TextFormField(
                  validator: QuizValidators().cannotNull,
                  decoration: InputDecoration(
                    labelText: "Ders Video URL'si ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                Gap(2.h),

                TextFormField(
                  maxLines: 5,
                  validator: QuizValidators().cannotNull,
                  decoration: InputDecoration(
                    labelText: 'Ders Açıklaması',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                Gap(3.h),

                ElevatedButton(
                  onPressed: () {
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
                  child: const Text('Dersi Ekle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
