class ExamResultModel {
  int score;
  bool isPassed;
  List<String>? answers;

  ExamResultModel({
    required this.score,
    required this.isPassed,
    required this.answers,
  });

  ExamResultModel copyWith({
    int? score,
    bool? isPassed,
    List<String>? answers,
  }) {
    return ExamResultModel(
      score: score ?? this.score,
      isPassed: isPassed ?? this.isPassed,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'isPassed': isPassed,
      'answers': answers,
    };
  }

  factory ExamResultModel.fromJson(Map<String, dynamic> json) {
    return ExamResultModel(
      score: json['score'] as int,
      isPassed: json['isPassed'] as bool,
      answers: (json['answers'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  @override
  String toString() =>
      "ExamResultModel(score: $score,isPassed: $isPassed,answers: $answers)";

  @override
  int get hashCode => Object.hash(score, isPassed, answers);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamResultModel &&
          runtimeType == other.runtimeType &&
          score == other.score &&
          isPassed == other.isPassed &&
          answers == other.answers;
}
