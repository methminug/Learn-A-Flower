class Flower {
  String? documentId;
  String flowerImage;
  String flowerName;
  String flowerDescription;

  Flower({
    this.documentId,
    required this.flowerImage,
    required this.flowerName,
    required this.flowerDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'flowerImage': flowerImage,
      'flowerName': flowerName,
      'flowerDescription': flowerDescription
    };
  }

  factory Flower.fromDocumentSnapshot(dynamic doc) {
    return Flower(
      documentId: doc.data()['documentId'],
      flowerImage: doc.data()['flowerImage'],
      flowerName: doc.data()['flowerName'],
      flowerDescription: doc.data()['flowerDescription'],
    );
  }
}
