class Quiz {
  final String id;
  final String title;
  final int level;
  final List<dynamic> questions;

  Quiz(
      {required this.id,
      required this.title,
      required this.level,
      required this.questions});

  factory Quiz.fromDocumentSnapshot(dynamic doc) {
    return Quiz(
      id: doc.data()['id'],
      title: doc.data()['title'],
      level: doc.data()['level'],
      questions: doc.data()['questions'],
    );
  }
}
