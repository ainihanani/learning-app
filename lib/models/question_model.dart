class QuestionModel{

  late String _question;

  String get question => _question;

  set question(String value) {
    _question = value;
  }
  late String option1;
  late String option2;
  late String option3;
  late String option4;
 late String correctOption;
  late bool answered;
}