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
    DocumentReference documentReferencer =
        _mainCollection.doc(toUser).collection(userUid!).doc();
    print('documentReferencer: $documentReferencer');
    Map<String, dynamic> data = <String, dynamic>{
      "dias": days,
      "desayuno": breakfast,
      "almuerzo": lunch,
      "cena": dinner,
      "aperitivos": snack,
      "enviado": userUid,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }
}
