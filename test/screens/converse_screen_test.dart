import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diga_la_app/data/datasources/sample_cards.dart';
import 'package:diga_la_app/providers/language_provider.dart';
import 'package:diga_la_app/screens/converse_screen.dart';
import 'package:diga_la_app/services/language_service.dart';
import 'package:diga_la_app/widgets/card_tile.dart';
import '../helpers/mocks.dart';

Widget buildTestApp({LanguageService? languageService}) {
  final settings = InMemorySettingsRepository();
  final ls = languageService ?? LanguageService(MockTtsService(), settings);

  return ProviderScope(
    overrides: [
      languageServiceProvider.overrideWith((ref) => ls),
    ],
    child: const MaterialApp(
      home: ConverseScreen(),
    ),
  );
}

void main() {
  testWidgets('apagar remove o último cartão da frase', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    final firstCard = find.text(sampleCards[0].labelPt).last;
    await tester.tap(firstCard);
    await tester.pumpAndSettle();

    final secondCard = find.text(sampleCards[1].labelPt).last;
    await tester.tap(secondCard);
    await tester.pumpAndSettle();

    await tester.tap(find.text('⌫'));
    await tester.pumpAndSettle();

    expect(find.text(sampleCards[0].labelPt), findsWidgets);
  });

  testWidgets('apagar com frase vazia não quebra', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('⌫'));
    await tester.pumpAndSettle();

    expect(find.byType(ConverseScreen), findsOneWidget);
  });

  testWidgets('limpar esvazia a frase inteira', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    final firstCard = find.text(sampleCards[0].labelPt).last;
    await tester.tap(firstCard);
    await tester.pumpAndSettle();

    final secondCard = find.text(sampleCards[1].labelPt).last;
    await tester.tap(secondCard);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Limpar'));
    await tester.pumpAndSettle();

    expect(find.text(sampleCards[0].labelPt), findsOneWidget);
  });

  testWidgets('grade renderiza cartões do mockup', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(sampleCards.length, 12);

    final cards = find.byType(CardTile);
    expect(cards, findsAtLeast(3));

    await tester.drag(find.byType(GridView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('card_obrigado')), findsOneWidget);
    expect(find.byKey(const Key('card_mais')), findsOneWidget);
  });

  testWidgets('botão Falar é ElevatedButton', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ElevatedButton, 'Falar'), findsOneWidget);
  });
}
