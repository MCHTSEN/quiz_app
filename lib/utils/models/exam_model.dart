import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/utils/models/question_model.dart';

class ExamModel {
  String? lessonName;
  String? subtitle;
  String? videoURL;
  String? description;
  List<QuestionModel>? questionModel;

  ExamModel({
    this.lessonName,
    this.subtitle,
    this.videoURL,
    this.description,
    this.questionModel,
  });
  // factory ExamModel.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return ExamModel(
  //     lessonName: data?['lessonName'],
  //     subtitle: data?['subtitle'],
  //     videoURL: data?['videoURL'],
  //     description: data?['description'],
  //     questionModel: data?['questionModel'] is Iterable
  //         ? List.from(data?['questionModel'])
  //         : null,
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (lessonName != null) "lessonName": lessonName,
  //     if (subtitle != null) "subtitle": subtitle,
  //     if (videoURL != null) "videoURL": videoURL,
  //     if (description != null) "description": description,
  //     if (questionModel != null) "questionModel": questionModel,
  //   };
  // }

  ExamModel copyWith({
    String? lessonName,
    String? subtitle,
    String? videoURL,
    String? description,
    List<QuestionModel>? questionModel,
  }) {
    return ExamModel(
      lessonName: lessonName ?? this.lessonName,
      subtitle: subtitle ?? this.subtitle,
      videoURL: videoURL ?? this.videoURL,
      description: description ?? this.description,
      questionModel: questionModel ?? this.questionModel,
    );
  }

  Map<String, dynamic> toJson() {
  final list = questionModel?.map((e) => QuestionModel().toJson(e)).toList();
    return {
      'lessonName': lessonName,
      'subtitle': subtitle,
      'videoURL': videoURL,
      'description': description,
      'questionModel': list,
    };
  }

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      lessonName: json['lessonName'] as String?,
      subtitle: json['subtitle'] as String?,
      videoURL: json['videoURL'] as String?,
      description: json['description'] as String?,
      questionModel: (json['questionModel'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() =>
      "ExamModel(lessonName: $lessonName,subtitle: $subtitle,videoURL: $videoURL,description: $description,questionModel: $questionModel)";

  @override
  int get hashCode =>
      Object.hash(lessonName, subtitle, videoURL, description, questionModel);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamModel &&
          runtimeType == other.runtimeType &&
          lessonName == other.lessonName &&
          subtitle == other.subtitle &&
          videoURL == other.videoURL &&
          description == other.description &&
          questionModel == other.questionModel;
}





// [
//     {
//         "lessonName": "1",
//         "subtitle": "Leanne Graham",
//         "videoURL": "Leanne Graham",
//         "description": "Sincere@april.biz",
//         "questionModel": [
//             {
//                 "question": "John Doe",
//                 "answers": [
//                     "12345"
//                 ],
//                 "correctAnswer": "John Doe",
//                 "passGrade": 1
//             }
//         ]
//     }
// ]