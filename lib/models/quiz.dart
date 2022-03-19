class Quiz {
  final String title;
  final int level;
  final List<Map<String, String>> questions;

  Quiz({required this.title, required this.level, required this.questions});

  factory Quiz.fromDocumentSnapshot(dynamic doc) {
    return Quiz(
      title: doc.data()['id'],
      level: doc.data()['name'],
      questions: doc.data()['questions'],
    );
  }
}
