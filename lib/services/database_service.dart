import 'dart:io';

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
    if (sortOrder != null) {
      sortOrder.forEach((sort) {
        collectionRef.orderBy(sort['field'], descending: sort['isDescending']);
      });
    }
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

  static Future<dynamic> update(
      String collection, List<dynamic> filters, dynamic data) async {
    dynamic collectionRef = _filteredCollection(collection, filters);
    dynamic result = true;

    await collectionRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((queryDoc) {
        FirebaseFirestore.instance
            .collection(collection)
            .doc(queryDoc.id)
            .update(data)
            .catchError((error) {
          print(error);
          result = false;
        });
      });
    }).catchError((error) {
      print(error);
      result = false;
    });

    return result;
  }
}

// STORING IMAGES
class FirebaseStorageService {
  static FirebaseStorage fireBaseStorage = FirebaseStorage.instance;

  static Future<String> uploadFile(
      File file, String fileName, String filepath) async {
    var storageRef = fireBaseStorage.ref().child('/$filepath/$fileName');

    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
}
