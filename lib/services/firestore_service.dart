import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/utils/enums/lesson_names.dart';
import 'package:quiz_app/utils/models/exam_model.dart';

final class FirestoneService {
  FirestoneService._();
  static FirestoneService get instance => FirestoneService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadExam(ExamModel examModel) async {
    await _db
        .collection('exams')
        .doc('exam')
        .collection(examModel.lessonName ?? '')
        .doc(examModel.subtitle.toString())
        .set(examModel.toJson())
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<List<ExamModel>> getExams(LessonNames lessonName) async {
    final ref = _db.collection('exams').doc('exam').collection(lessonName.name);

    final docSnap = await ref.get();
    final examModelData = docSnap.docs;
    // We fetch all subtitles
    List<Map<String, dynamic>> dataList =
        examModelData.map((snapshot) => snapshot.data()).toList();

    // We cast subtitles as ExamModel
    List<ExamModel> examList =
        dataList.map((e) => ExamModel.fromJson(e)).toList();
    return examList;
  }
}
