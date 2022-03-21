import 'package:flutter/material.dart';

import '../../../helpers/colors.dart';
import '../../../routes/app_routes.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile(
      {Key? key,
      required this.questionInfo,
      required this.quizId,
      required this.questionId})
      : super(key: key);
  final Map<String, dynamic> questionInfo;
  final int questionId;
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Hero(
              tag: questionInfo['image'].toString(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Image.network(
                  questionInfo['image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionInfo.containsKey('question')
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        questionInfo['question'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 4),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  'Answer: ${questionInfo['answer'].toString()}',
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.QUIZ_MANAGEMENT_EDIT_QUESTION,
                arguments: {
                  'quiz_id': quizId,
                  'question_id': questionId,
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.primary),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 27.5, 8, 27.5),
                child: const Center(
                    child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 22,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}