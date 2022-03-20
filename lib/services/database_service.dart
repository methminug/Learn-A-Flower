import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudFirestoreService {
  static dynamic _filteredCollection(String collection, List<dynamic> filters,
      {sortOrder}) {
    dynamic collectionRef;
    collectionRef = FirebaseFirestore.instance.collection(collection);
    filters.forEach((filter) {
      collectionRef =
          collectionRef.where(filter['name'], isEqualTo: filter['value']);
    });
    sortOrder.forEach((sort) {
      collectionRef.orderBy(sort['field'], descending: sort['isDescending']);
    });
    return collectionRef;
  }

  static Future<dynamic> write(
      String collection, dynamic payload, String successMessage) async {
    dynamic res;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(collection);
    await collectionRef.add(payload).then((value) {
      res = successMessage;
    }).catchError((error) {
      print(error);
    });
    return res;
  }

  static Future<dynamic> read(String collection, List<dynamic> filters,
      {limit, sortOrder}) async {
    List<dynamic> data = [];
    dynamic collectionRef =
        _filteredCollection(collection, filters, sortOrder: sortOrder);
    if (limit != null) collectionRef = collectionRef.limit(limit);
    await collectionRef.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) data = querySnapshot.docs;
    });
    return limit == 1 ? (data.isNotEmpty ? data[0] : null) : data;
  }
}

class FirebaseStorageService {}
