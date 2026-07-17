import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/app.dart';

void main() {
  testWidgets('Conversar is ElevatedButton, Aprender is OutlinedButton', (
    tester,
  ) async {
    await tester.pumpWidget(const App());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final converseButton = find.widgetWithText(ElevatedButton, 'Conversar');
    final learnButton = find.widgetWithText(OutlinedButton, 'Aprender');

    expect(converseButton, findsOneWidget);
    expect(learnButton, findsOneWidget);
  });
}
