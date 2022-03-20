import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/question_tile.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<dynamic> _onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
    final questions = arguments['quiz_info'].questions as List<dynamic>;
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: Scaffold(
        appBar: AppBar(title: Text(arguments['quiz_info'].title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO IMPLMENT PLAY FEATURE
            print('Play Quiz');
          },
          child: const Icon(Icons.play_arrow_rounded),
          tooltip: 'Preview this quiz',
        ),
        backgroundColor: AppColors.appBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: ListView.builder(
              itemCount: questions.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: ElevatedButton(
                          child: Row(
                            children: const [
                              Text(
                                "+ ",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                " Add new question",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.QUIZ_MANAGEMENT_NEW_QUESTION,
                                arguments: {
                                  'quiz_info': arguments['quiz_info']
                                });
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    child: QuestionTile(
                      quizId: arguments['quiz_info'].id,
                      questionId: index - 1,
                      questionInfo: questions[index - 1],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
