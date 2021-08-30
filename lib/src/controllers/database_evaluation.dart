import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('evaluations');

class DatabaseEvaluations {
  static String? userUid;
  //Ingresar alimentación
  static Future<void> addFood({
    /// datos dek usuario con sesion activa
    required String myWeight,
    required String myHeight,
    required String myAge,

    /// alimentación
    required String days,
    required String breakfast,
    required String lunch,
    required String dinner,
    required String snack,
    required String? toUser,
  }) async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    DocumentReference documentReferencer = _mainCollection
        .doc(toUser)
        .collection('contacts')
        .doc(userUid)
        .collection('evaluations')
        .doc('$date - $time');
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      "peso": myWeight,
      "estatura": myHeight,
      "edad": myAge,
      "dias": days,
      "desayuno": breakfast,
      "almuerzo": lunch,
      "cena": dinner,
      "aperitivos": snack,
      "enviado": userUid,
      "evaluation": "",
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addFoodEvaluated({
    required String days,
    required String breakfast,
    required String lunch,
    required String dinner,
    required String snack,
    required String? toUser,
    required String carriedEvaluationId,
    required String evaluation,
  }) async {
    DocumentReference documentReferencer = _mainCollection
        .doc(toUser)
        .collection('contacts')
        .doc(userUid)
        .collection('evaluations')
        .doc(carriedEvaluationId);
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      "dias": days,
      "desayuno": breakfast,
      "almuerzo": lunch,
      "cena": dinner,
      "aperitivos": snack,
      "enviado": userUid,
      "evaluation": evaluation,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateFoodEvaluated({
    required String days,
    required String breakfast,
    required String lunch,
    required String dinner,
    required String snack,
    required String? toUser,
    required String carriedEvaluationId,
    required String evaluation,
  }) async {
    DocumentReference documentReferencer = _mainCollection
        .doc(userUid)
        .collection('contacts')
        .doc(toUser)
        .collection('evaluations')
        .doc(carriedEvaluationId);
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      "dias": days,
      "desayuno": breakfast,
      "almuerzo": lunch,
      "cena": dinner,
      "aperitivos": snack,
      "enviado": userUid,
      "evaluation": evaluation,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addContact({
    required String fromUser,
    required String emailFromUser,
    required String? toUser,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(toUser).collection('contacts').doc(emailFromUser);
    Map<String, dynamic> data = <String, dynamic>{
      "nombre": fromUser,
      "email": emailFromUser,
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readContacts() {
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection('contacts');
    return userCollection.snapshots();
  }

  static Stream<QuerySnapshot> readNotificationId(contactId) {
    CollectionReference userCollection = _mainCollection
        .doc(userUid)
        .collection('contacts')
        .doc(contactId)
        .collection('evaluations');
    return userCollection.snapshots();
  }

  // static Stream<DocumentSnapshot> readFood(contactId, foodId) {
  //   DocumentReference documentReference = _mainCollection
  //       .doc(userUid)
  //       .collection('contacts')
  //       .doc(contactId)
  //       .collection('evaluations')
  //       .doc(foodId);
  //   return documentReference.snapshots();
  // }
}
