class Disease {
  final String? id;
  final String disease_name;
  final String disease_description;
  final String disease_image;
  Disease(
      {this.id,
        required this.disease_name,
        required this.disease_description,
        required this.disease_image});

  Map<String, dynamic> toMap() {
    return {
      'disease_name': disease_name,
      'disease_description': disease_description,
      'disease_image': disease_image
    };
  }

  factory Disease.fromDocumentSnapshot(dynamic doc) {
    return Disease(
      id: doc.data()['id'],
      disease_name: doc.data()['disease_name'],
      disease_description: doc.data()['disease_description'],
      disease_image: doc.data()['disease_image'],
    );
  }
}