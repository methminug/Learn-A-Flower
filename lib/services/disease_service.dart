import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_a_flower_app/models/disease.dart';

class DiseaseService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> addDisease(Disease diseaseData) async {
    final docFlowerDisease = FirebaseFirestore.instance.collection('FlowerDisease').doc();
    // diseaseData.id = docFlowerDisease.id;
    await docFlowerDisease.set({
      'id': docFlowerDisease.id,
      'disease_image': diseaseData.disease_image,
      'disease_name': diseaseData.disease_name,
      'disease_description': diseaseData.disease_description
    });
    return docFlowerDisease.id;
  }

  static Future updateDisease(Disease diseaseData) async {
    final docFlowerDisease =
    FirebaseFirestore.instance.collection('FlowerDisease').doc(diseaseData.id);
    await docFlowerDisease
        .update({
      'disease_image': diseaseData.disease_image,
      'disease_name': diseaseData.disease_name,
      'disease_description': diseaseData.disease_description
    })
        .then((value) => print('updated'))
        .catchError((error) => print('not working $error'));
  }

  Future<void> deleteDisease(String documentId) async {
    await _db.collection('FlowerDisease').doc(documentId).delete();
  }

  Future<List<Disease>> retrieveDisease() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection('FlowerDisease').get();
    return (snapshot.docs)
        .map((docSnapshot) => Disease.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
