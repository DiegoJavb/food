import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');
final CollectionReference _allUserCollection =
    _firestore.collection('usersList');

class DatabaseUser {
  static String? userUid;
  //BASE DE DATOS DE USUARIOS
  static Future<void> addUser({
    required String email,
    required String role,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('information').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'email': email,
      'role': role,
      'name': '',
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUser() {
    print('uid del usuarii}o actual: $userUid');
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection('information');
    return userCollection.snapshots();
  }

  static Future<void> updateUser({
    required String photo,
    required String name,
    required String weight,
    required String height,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('information').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "photo": photo,
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

  //BASE DE DATOS PARA CONTACTOS
  static Future<void> addContact({
    required String name,
    required String email,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('contacts').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'email': email,
      'docId': docId,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  //Leer mis usuarios
  static Stream<QuerySnapshot> readMyContacts() {
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection('contacts');
    return userCollection.snapshots();
  }

  //BASE DE DATOS UUARIOS TOTALES
  static Future<void> addUserOnListUsers({
    required String photo,
    required String name,
    required String email,
    required String docId,
  }) async {
    DocumentReference documentReference = _allUserCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'photo': photo,
      'name': name,
      'email': email,
      'userUid': docId,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUsersOfListUsers() {
    CollectionReference userCollection = _allUserCollection;
    return userCollection.snapshots();
  }

  //BASE DE DATOS PARA EL CONSUMO ALIMENTICIO
  static Future<void> addRecomendation({
    required String level,
    required String food,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('recomendations').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'level': level,
      'food': food,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readRecomendation() {
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection('recomendations');
    return userCollection.snapshots();
  }
}
