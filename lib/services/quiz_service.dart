import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/quiz.dart';
import 'package:learn_a_flower_app/models/quiz_question.dart';
import 'package:learn_a_flower_app/services/database_service.dart';

class QuizService {
  static Future<List<Quiz>> getQuizList(int level) async {
    List<dynamic> filters = [];
    List<dynamic> sortOrder = [
      {
        'field': 'level',
        'isDescending': false,
      }
    ];

    if (level != 0) filters.add({'name': 'level', 'value': level});

    final responses =
        await CloudFirestoreService.read('quiz', filters, sortOrder: sortOrder);

    return (responses as List)
        .map((doc) => Quiz.fromDocumentSnapshot(doc))
        .toList();
  }

  static Future<dynamic>? addNewQuestion(
      String quizID, List<dynamic> newQuestions, File image) async {
    newQuestions.last['image'] = await FirebaseStorageService.uploadFile(
        image, (newQuestions.length - 1).toString(), 'question-images/$quizID');

    //Get quiz document
    List<dynamic> filters = [
      {'name': 'id', 'value': quizID}
    ];

    return await CloudFirestoreService.update(
        'quiz', filters, {'questions': newQuestions});
  }
}
