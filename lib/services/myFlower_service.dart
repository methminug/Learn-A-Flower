import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/myFlower.dart';

class myFlowersService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addEmployee(MyFlowers myFlowers) async {
    await _db.collection("MyFlowers").add(myFlowers.toMap());
  }

  updateMyFlowers(MyFlowers myFlowers) async {
    await _db.collection("MyFlowers").doc(myFlowers.id).update(
        myFlowers.toMap());
  }

  Future<void> deleteMyFlowers(String documentId) async {
    await _db.collection("MyFlowers").doc(documentId).delete();

}

Future<List<MyFlowers>> retrieveMyFlowers() async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
  await _db.collection("MyFlowers").get();
  return snapshot.docs
      .map((docSnapshot) => MyFlowers.fromDocumentSnapshot(docSnapshot))
      .toList();
}
}