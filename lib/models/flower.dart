class Flower {
  String? id;
  String flowerImage;
  String flowerName;
  String flowerDescription;
  String flowerInfoURL;

  Flower({
    this.id,
    required this.flowerImage,
    required this.flowerName,
    required this.flowerDescription,
    required this.flowerInfoURL,
  });

  Map<String, dynamic> toMap() =>
      {
        'flowerImage': flowerImage,
        'flowerName': flowerName,
        'flowerDescription': flowerDescription,
        'flowerInfoURL': flowerInfoURL,
      };

  factory Flower.fromDocumentSnapshot(dynamic doc) {
    return Flower(
      id: doc.data()['id'],
      flowerImage: doc.data()['flowerImage'],
      flowerName: doc.data()['flowerName'],
      flowerDescription: doc.data()['flowerDescription'],
      flowerInfoURL: doc.data()['flowerInfoURL'],
    );
  }
}
