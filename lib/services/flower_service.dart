import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_a_flower_app/models/flower.dart';

class FlowerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Add new flower
  static Future<String> addFlower(Flower flowerData) async {
    final docFlower = FirebaseFirestore.instance.collection('Flowers').doc();
    flowerData.id = docFlower.id;
    await docFlower.set({
      'id': flowerData.id,
      'flowerImage': flowerData.flowerImage,
      'flowerName': flowerData.flowerName,
      'flowerDescription': flowerData.flowerDescription,
      'flowerInfoURL': flowerData.flowerInfoURL
    });
    return docFlower.id;
  }

  //Update flower
  static Future updateFlower(Flower flowerData) async {
    final docFlower =
        FirebaseFirestore.instance.collection('Flowers').doc(flowerData.id);
    await docFlower
        .update({
          'flowerImage': flowerData.flowerImage,
          'flowerName': flowerData.flowerName,
          'flowerDescription': flowerData.flowerDescription,
          'flowerInfoURL': flowerData.flowerInfoURL
        })
        .then((value) => print('updated'))
        .catchError((error) => print('not working $error'));
  }

  //Delete flower
  Future<void> deleteFlower(String flowerDocId) async {
    await _db.collection('Flowers').doc(flowerDocId).delete();
  }

  //Get all flowers
  Future<List<Flower>> getFlowers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('Flowers').get();
    return (snapshot.docs)
        .map((docSnapshot) => Flower.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
