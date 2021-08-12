import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('evaluations');

class DatabaseEvaluations {
  static String? userUid;
  //Ingresar alimentación
  static Future<void> addFood({
    required String days,
    required String breakfast,
    required String lunch,
    required String dinner,
    required String snack,
    required String? toUser,
  }) async {
    var timeKey = DateTime.now();
    DocumentReference documentReferencer = _mainCollection
        .doc(toUser)
        .collection('contacts')
        .doc(userUid)
        .collection('evaluations')
        .doc(timeKey.toString());
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
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

  static Future<void> addPatient({
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

  static Stream<QuerySnapshot> readPatients() {
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
