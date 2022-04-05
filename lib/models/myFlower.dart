
class WonderfulFlowers {
  final String? id;
  final String flowerName;
  final String image;
  final String notes;

  WonderfulFlowers({this.id,
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

  factory WonderfulFlowers.fromDocumentSnapshot(dynamic doc)
  {
    return WonderfulFlowers(
        flowerName: doc.data()!["flowerName"],
        image: doc.data()!["image"],
        notes: doc.data()!["notes"]
    );
  }
}
