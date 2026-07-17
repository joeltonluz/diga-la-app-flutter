import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/app.dart';

void main() {
  testWidgets('App starts at splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Diga Lá'), findsOneWidget);
    expect(find.text('Comunicação que aproxima'), findsOneWidget);
  });

  testWidgets('App navigates to home after splash', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Conversar'), findsOneWidget);
    expect(find.text('Aprender'), findsOneWidget);
  });

  testWidgets('home subtitle has no emoji', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Comunicação que aproxima'), findsOneWidget);
    expect(find.textContaining('🧩'), findsNothing);
  });

  testWidgets('home title color is not primary', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final theme = ThemeData.light();
    final primaryColor = theme.colorScheme.primary;

    final titleText = tester.widget<Text>(
      find.text('Diga Lá').last,
    );

    expect(titleText.style?.color, isNot(equals(primaryColor)));
  });
}
