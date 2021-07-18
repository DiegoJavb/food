import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class DatabaseUser {
  static String? userUid;

  static Future<void> addUser({
    required String email,
    required String role,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('user').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'email': email,
      'role': role,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUser() {
    print(userUid);
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection('user');
    return userCollection.snapshots();
  }

  static Future<void> updateUser({
    required String name,
    required String weight,
    required String height,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('user').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "weight": weight,
      "height": height,
      "age": age,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("usuario actualizado en la BDD"))
        .catchError((e) => print(e));
  }
}
