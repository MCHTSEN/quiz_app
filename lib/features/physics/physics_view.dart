import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app/services/firestore_service.dart';
import 'package:quiz_app/utils/constants/quiz_api_keys.dart';
import 'package:quiz_app/utils/enums/lesson_names.dart';
import 'package:quiz_app/utils/models/exam_model.dart';
import 'package:quiz_app/utils/widgets/custom_listile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PhysicsView extends ConsumerStatefulWidget {
  const PhysicsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhysicsViewState();
}

class _PhysicsViewState extends ConsumerState<PhysicsView> {
  late Future<List<ExamModel>> _lessonsFuture;

  @override
  void initState() {
    super.initState();
    _lessonsFuture = getLessons(LessonNames.Matematik);
  }

  Future<List<ExamModel>> getLessons(LessonNames lessonName) async {
    final response = await FirestoneService.instance.getExams(lessonName);
    inspect(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: FutureBuilder<List<ExamModel>>(
          future: _lessonsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final exams = snapshot.data!;
              return ListView.builder(
                itemCount: exams.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      CustomListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TakeLessonView(
                                exam: exams[index],
                              ),
                            ),
                          );
                        },
                        title: exams[index].subtitle,
                      ),
                      Gap(1.h)
                    ],
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
