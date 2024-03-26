class QuizValidators {
  String? cannotNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bos gecilemez';
    }
    return null;
  }
}
