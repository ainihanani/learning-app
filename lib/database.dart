import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addData(Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId) // Using .doc instead of .document for v4.x.x
        .set(quizData) // Using .set instead of .setData for v4.x.x
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addQuestionData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
