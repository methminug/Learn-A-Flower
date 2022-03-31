import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_a_flower_app/models/flower.dart';

class FlowerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  addFlower(Flower flowerData) async {
    await _db.collection('Flowers').add(flowerData.toMap());
  }

  updateFlower(Flower flowerData) async {
    await _db.collection('Flowers').doc(flowerData.documentId).update(flowerData.toMap());
  }

  Future<void> deleteFlower(String flowerDocId) async {
    await _db.collection('Flowers').doc(flowerDocId).delete();
  }

  Future<List<Flower>> getFlowers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('Flowers').get();
    return (snapshot.docs)
        .map((docSnapshot) => Flower.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}