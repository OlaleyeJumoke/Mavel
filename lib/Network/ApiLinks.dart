// questionList(
//       String difficultyLevel, String numberOfQuestions /*, String time*/) {
//     var data = _fetchedQuestions.questionUpdate(difficultyLevel, numberOfQuestions);
//     print(data);
//     return FutureBuilder<List<QuestionModel>>(
//         future: _fetchedQuestions.questionUpdate(difficultyLevel, numberOfQuestions),
//         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//           print('SnapShot: ${snapshot.data}');
//           if (snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             print('SnapShot1: ${snapshot.data}');
//             List<QuestionModel> questionData = snapshot.data;

//             return new CustomQuestionView(
//                 questionData: questionData, difficultyLevel: difficultyLevel);
//           }

//           return new Container(
//               alignment: Alignment.topCenter,
//               padding: const EdgeInsets.only(top: 16.0),
//               child: CircularProgressIndicator(
//                 strokeWidth: 2.0,
//               ));
//         });
//   }
