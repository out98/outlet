import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final firestore = FirebaseFirestore.instance;

  Future<void> write({
    required String collectionPath,
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).set(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watch(String collectionPath) =>
      firestore.collection(collectionPath).orderBy("dateTime").snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> watchSimple(
          String collectionPath) =>
      firestore.collection(collectionPath).snapshots();

  Future<QuerySnapshot<Map<String, dynamic>>> readCollectionWhere({
    required String collectionPath,
    required dynamic field,
    required dynamic equalField,
  }) async {
    return await firestore
        .collection(collectionPath)
        .where(field, isEqualTo: equalField)
        .get();
  }

  Future<void> delete({
    required String collectionPath,
    required String documentPath,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).delete();
  }
}
