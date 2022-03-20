import 'package:learn_a_flower_app/models/quiz.dart';
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
}
