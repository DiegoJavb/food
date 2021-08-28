import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');
final CollectionReference _allUserCollection =
    _firestore.collection('usersList');

class DatabaseUser {
  static String? userUid;
  //BASE DE DATOS DE USUARIOS
  //Añadir usuario a la base de datos sin toda su información
  static Future<void> addUser({
    required String email,
    required String role,
    required String docId,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(email);

    Map<String, dynamic> data = <String, dynamic>{
      'email': email,
      'role': role,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  //Añadir toda la información del usuario a la base de datos
  //solo datos provistos por el usuario
  //utilizamos el (SET) en el await de la función
  static Future<void> addUserInfo({
    required String photo,
    required String name,
    required String email,
    required String role,
    required String weight,
    required String height,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('information').doc(email);

    Map<String, dynamic> data = <String, dynamic>{
      "photo": photo,
      "name": name,
      "weight": weight,
      "height": height,
      "age": age,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("usuario actualizado en la BDD"))
        .catchError((e) => print(e));
  }

  //Actualizamos toda la información del usuario a la base de datos
  //solo datos provistos por el usuario
  //utilizamos el (UPDATE) en el await de la función
  static Future<void> updateUserInfo({
    required String photo,
    required String name,
    required String email,
    required String role,
    required String weight,
    required String height,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email).collection('information').doc(email);

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
  //Añadir contacto a la base de datos
  static Future<void> addContact({
    required String name,
    required String photoUrl,
    required String role,
    required String email,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('contacts').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
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

  //BASE DE DATOS USUARIOS TOTALES
  //Cuando un usuario actualiza su información,
  //esta se hace visible para el resto de
  //usuarios de la app
  //Añadir usuario a la base de datos de usuarios totales
  static Future<void> addUserOnListUsers({
    required String photo,
    required String name,
    required String email,
    required String role,
    required String docId,
  }) async {
    DocumentReference documentReference = _allUserCollection.doc(email);

    Map<String, dynamic> data = <String, dynamic>{
      'photo': photo,
      'name': name,
      'email': email,
      'userUid': docId,
      'role': role,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateUserOnListUsers({
    required String photo,
    required String name,
    required String email,
    required String role,
    required String docId,
  }) async {
    DocumentReference documentReference = _allUserCollection.doc(email);

    Map<String, dynamic> data = <String, dynamic>{
      'photo': photo,
      'name': name,
      'email': email,
      'userUid': docId,
      'role': role,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUsersOfListUsers() {
    CollectionReference userCollection = _allUserCollection;
    return userCollection.snapshots();
  }

  //BASE DE DATOS PARA EL CONSUMO ALIMENTICIO
  //Añadir un alimeto a la base de datos
  static Future<void> addRecomendation({
    required String food,
    required String level,
    required String colorLevel,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('recomendations').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'food': food,
      'level': level,
      'colorLevel': colorLevel,
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

  static Future<void> deleteFood({
    required String foodId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('recomendations').doc(foodId);
    print('documentReferencer: $documentReferencer');
    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
