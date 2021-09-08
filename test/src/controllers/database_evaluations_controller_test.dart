import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final instance = FakeFirebaseFirestore();
  String emisor = 'emisorID';
  String receptor = 'receptorID';
  Map<String, dynamic> data = <String, dynamic>{
    "desayuno": 'some breakfast',
    "almuerzo": 'some lunch',
    "enviado": emisor,
  };
  await instance
      .collection('evaluations')
      .doc(receptor)
      .collection('contacts')
      .doc(emisor)
      .collection('evaluations')
      .doc('documentID')
      .set(data);

  final snapshot = await instance
      .collection('evaluations')
      .doc(receptor)
      .collection('contacts')
      .doc(emisor)
      .collection('evaluations')
      .get();
  test('Test envio de consumo alimenticia: ', () {
    expect(snapshot.docs.first.get('enviado'), emisor);
  });
  print(instance.dump());
}
