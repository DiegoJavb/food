import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food/src/pages/information_page.dart';

Widget createInformationScreen() => MaterialApp(
      home: InformationPage(),
    );

void main() {
  group('Test de widget en la Página Informativa, ', () {
    testWidgets('se muestra un SingleChildScrollView en la página',
        (tester) async {
      await tester.pumpWidget(createInformationScreen());
      //then
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
