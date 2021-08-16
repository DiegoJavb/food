import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('userInformation');

class DatabaseUserInfo {
  static String? userUid;
  //BASE DE DATOS DE USUARIOS
  static Future<void> addUser({
    required String photoUrl,
    required String name,
    required String email,
    required String role,
    required String weight,
    required String height,
    required String age,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('information').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'photo': photoUrl,
      'name': name,
      'email': email,
      'role': role,
      'weight': weight,
      'height': height,
      'age': age,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateUser({
    required String photo,
    required String name,
    required String weight,
    required String height,
    required String age,
  }) async {
    print(userUid);
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('information').doc();
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      'photo': photo,
      'name': name,
      'weight': weight,
      'height': height,
      'age': age,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUser() {
    CollectionReference notesItemCollection = _mainCollection;
    return notesItemCollection.snapshots();
  }
}
