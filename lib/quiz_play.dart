import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/models/question_model.dart';
import 'package:learning_app/database.dart';
import 'package:learning_app/widgets/widget.dart';
import 'package:learning_app/quiz_play_widgets.dart';

class QuizPlay extends StatefulWidget {
  final String quizId;

  QuizPlay(String id, {required this.quizId});

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> {
  late QuerySnapshot questionSnapshot;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  fetchQuestions() async {
    try {
      questionSnapshot = await databaseService.getQuestionData(widget.quizId);
      setState(() {
        isLoading = false;
      });
      print("Fetched ${questionSnapshot.docs.length} questions.");
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : questionSnapshot.docs.isEmpty
              ? Center(child: Text("No Data"))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      InfoHeader(
                        length: questionSnapshot.docs.length,
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: questionSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          return QuizPlayTile(
                            questionModel: getQuestionModelFromDatasnapshot(
                                questionSnapshot.docs[index]),
                            index: index,
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }

  QuestionModel getQuestionModelFromDatasnapshot(DocumentSnapshot questionSnapshot) {
  QuestionModel questionModel = new QuestionModel();

  // Cast to Map<String, dynamic> to resolve the operator '[]' error
  Map<String, dynamic> data = questionSnapshot.data() as Map<String, dynamic>;

  var newVariable = data["question"] as String;
  questionModel.question = newVariable;
  
  List<String> options = [
    data["option1"] as String,
    data["option2"] as String,
    data["option3"] as String,
    data["option4"] as String,
  ];
  
  options.shuffle();
  questionModel.option1 = options[0];
  questionModel.option2 = options[1];
  questionModel.option3 = options[2];
  questionModel.option4 = options[3];
  questionModel.correctOption = data["option1"] as String;
  questionModel.answered = false;

  print(questionModel.correctOption.toLowerCase());

  return questionModel;
}

  @override
  void dispose() {
   var infoStream = null;
     super.dispose();
  }

  @override
  Widget buildQuiz(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    InfoHeader(
                      length: questionSnapshot!.docs.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    questionSnapshot!.docs.isEmpty
                        ? Container(
                            child: Center(
                              child: Text("No Data"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: questionSnapshot!.docs.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return QuizPlayTile(
                                questionModel: getQuestionModelFromDatasnapshot(
                                    questionSnapshot!.docs[index]),
                                index: index,
                              );
                            }),
                  ],
                ),
              ),
            ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  var infoStream;

  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  get infoStream => null;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 14),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      NoOfQuestionTile(
                        text: "Total",
                        number: widget.length,
                      ),
                      NoOfQuestionTile(
                        text: "Correct",
                        number: _correct,
                      ),
                      NoOfQuestionTile(
                        text: "Incorrect",
                        number: _incorrect,
                      ),
                      NoOfQuestionTile(
                        text: "NotAttempted",
                        number: _notAttempted,
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

// Define the variables
int _notAttempted = 0;
int _incorrect = 0;
int _correct = 0;

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.questionModel.question}",
              style: TextStyle(
                  fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "A",
              description: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
