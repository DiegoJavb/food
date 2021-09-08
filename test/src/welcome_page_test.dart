import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/src/pages/welcome_page.dart';

Widget createWelcomeScreen() => MaterialApp(
      home: WelcomePage(),
    );
void main() {
  group('Welcome Page widget test', () {
    testWidgets('Testing if SingleChildScrollView shows up', (tester) async {
      await tester.pumpWidget(createWelcomeScreen());
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
