
class MyFlowers {
  final String? id;
  final String flowerName;
  final String image;
  final String notes;

  MyFlowers({this.id,
    required this.flowerName,
    required this.image,
    required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'flowerName': flowerName,
      'image': image,
      'notes': notes,
    };
  }

  factory MyFlowers.fromDocumentSnapshot(dynamic doc)
  {
    return MyFlowers(
        flowerName: doc.data()!["flowerName"],
        image: doc.data()!["image"],
        notes: doc.data()!["notes"]
    );
  }
}