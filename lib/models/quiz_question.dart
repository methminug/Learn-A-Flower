class QuizQuestion {
  int id = 0;
  String image = '';
  final String question;
  final int answer;
  final List<String> options;

  QuizQuestion(
      {required this.id,
      required this.image,
      required this.question,
      required this.answer,
      required this.options});

  QuizQuestion.newQuestion(
      {required this.answer, required this.options, required this.question});

  factory QuizQuestion.fromDocumentSnapshot(dynamic doc) {
    return QuizQuestion(
        id: doc.data()['id'],
        answer: doc.data()['answer'],
        image: doc.data()['image'],
        options: doc.data()['options'],
        question: doc.data()['question']);
  }

  static toJSON(QuizQuestion question) {
    return {
      'image': question.image,
      'question': question.question,
      'answer': question.answer,
      'options': question.options
    };
  }
}
