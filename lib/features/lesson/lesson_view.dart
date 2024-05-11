import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:quiz_app/features/take_lesson/take_lesson_view.dart';
import 'package:quiz_app/provs/exam_provider.dart';
import 'package:quiz_app/services/firestore_service.dart';
import 'package:quiz_app/utils/constants/quiz_api_keys.dart';
import 'package:quiz_app/utils/enums/lesson_names.dart';
import 'package:quiz_app/utils/models/exam_model.dart';
import 'package:quiz_app/utils/models/exam_result_model.dart';
import 'package:quiz_app/utils/widgets/custom_listile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LessonView extends ConsumerStatefulWidget {
  final LessonNames pickedLesson;
  const LessonView(this.pickedLesson, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LessonViewState();
}

class _LessonViewState extends ConsumerState<LessonView> {
  late Future<List<LessonModel>> _lessonsFuture;
  int canTakeLessonIndex = 0;
  late List<ExamResultModel>? examResults;

  @override
  void initState() {
    super.initState();
    // canTakeLesson(widget.pickedLesson);
    _lessonsFuture = getLessons(widget.pickedLesson);
  }

  Future<List<LessonModel>> getLessons(LessonNames lessonName) async {
    final response = await FirestoreService.instance.getExams(lessonName);
    await canTakeLesson(lessonName);
    print('can take: $canTakeLessonIndex');
    inspect(response);
    return response;
  }

  Future<void> canTakeLesson(LessonNames lessonName) async {
    examResults = await FirestoreService.instance.getExamResults(lessonName);
    for (var result in examResults!) {
      if (result.isPassed) {
        canTakeLessonIndex++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konu Başlıkları'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: FutureBuilder<List<LessonModel>>(
          future: _lessonsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final lessons = snapshot.data!;
              return lessons.isEmpty
                  ? Center(
                      child: Text(
                      'Görüntülenecek ders kaydı bulunamadı.',
                      style: context.general.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ))
                  : ListView.builder(
                      itemCount: lessons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: CustomListTile(
                            canTakeLessonIndex: canTakeLessonIndex,
                            index: index,
                            onTap: () {
                              ref
                                  .read(currentLessonNotifier.notifier)
                                  .setLesson(lessons[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TakeLessonView(
                                    lessons[index],
                                  ),
                                ),
                              );
                            },
                            title: lessons[index].subtitle,
                          ),
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
