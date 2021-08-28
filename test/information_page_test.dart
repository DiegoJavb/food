import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/src/pages/information_page.dart';

Widget createInformationScreen() => MaterialApp(
      home: InformationPage(),
    );

void main() {
  group('Information Page widget test', () {
    testWidgets('Testing if SingleChildScrollView shows up', (tester) async {
      await tester.pumpWidget(createInformationScreen());
      //then
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
