import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/src/providers/role_pass.dart' as role;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
late final CollectionReference _mainCollection = role.rolUser == 'patient'
    ? _firestore.collection('patient')
    : _firestore.collection('nutritionist');

class DatabaseUser {
  //Ingresar cita
  static Future<void> addUser({required String name}) {
    return _mainCollection
        .add({
          'name': name,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // //Actualizar cita
  // static Future<void> updateItem({
  //   required String title,
  //   required String description,
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('appointment').doc(docId);

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //     "description": description,
  //   };

  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() => print("Note item updated in the database"))
  //       .catchError((e) => print(e));
  // }

  // //Leer cita
  // static Stream<QuerySnapshot> readItems() {
  //   CollectionReference notesItemCollection =
  //       _mainCollection.doc(userUid).collection('appointment');

  //   return notesItemCollection.snapshots();
  // }

  // //Eliminar cita
  // static Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('appointment').doc(docId);

  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }
}
