// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/src/controllers/database_evaluation.dart';
// import 'package:mockito/mockito.dart';

// class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

void main() {
  group('Send evaluation test', () {
    test('is sended: ', () {
      expect(
          DatabaseEvaluations.addFood(
            breakfast: '',
            days: '',
            dinner: '',
            lunch: '',
            snack: '',
            toUser: '',
          ),
          '');
    });
  });
}
