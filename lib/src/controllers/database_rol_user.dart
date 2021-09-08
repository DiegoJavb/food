import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('rolUser');

class DatabaseRoleUser {
  static String? userUid;

  static Future<void> addRolUser({
    required String role,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('information').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'role': role,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUser() {
    CollectionReference notesItemCollection = _mainCollection;
    return notesItemCollection.snapshots();
  }
}
