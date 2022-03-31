import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/disease.dart';

class DiseaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addDisease(Disease diseaseData) async {
    await _db.collection("FlowerDisease").add(diseaseData.toMap());
  }

  updateDisease(Disease diseaseData) async {
    await _db.collection("FlowerDisease").doc(diseaseData.id).update(
        diseaseData.toMap());
  }

  Future<void> deleteDisease(String documentId) async {
    await _db.collection("FlowerDisease").doc(documentId).delete();
  }

  Future<List<Disease>> retrieveDisease() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("FlowerDisease").get();
    return snapshot.docs
        .map((docSnapshot) => Disease.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}