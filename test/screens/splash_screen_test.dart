import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/app.dart';

void main() {
  testWidgets('splash exibe Diga La e subtitulo', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Diga Lá'), findsOneWidget);
    expect(find.text('Comunicação que aproxima'), findsOneWidget);
  });

  testWidgets('splash exibe o logo', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('tocar na splash navega para o Inicio', (tester) async {
    await tester.pumpWidget(const App());

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    expect(find.text('Conversar'), findsOneWidget);
    expect(find.text('Aprender'), findsOneWidget);
  });

  testWidgets('timer de 2s navega automaticamente para Inicio', (tester) async {
    await tester.pumpWidget(const App());

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Conversar'), findsOneWidget);
    expect(find.text('Aprender'), findsOneWidget);
  });
}
