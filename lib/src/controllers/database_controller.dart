import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('appointment');

class Database {
  static String? userUid;

  //Ingresar cita
  static Future<void> addItem({
    required String title,
    required String description,
    required String contact,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('appointment').doc();
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      "contact": contact,
      "title": title,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  //Actualizar cita
  static Future<void> updateItem({
    required String title,
    required String contact,
    required String description,
    required String docId,
  }) async {
    print(userUid);
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('appointment').doc(docId);
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "contact": contact,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  //Leer cita
  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('appointment');
    print('notesItemCollection: $notesItemCollection');
    return notesItemCollection.snapshots();
  }

  //Eliminar cita
  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('appointment').doc(docId);
    print('documentReferencer: $documentReferencer');
    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
