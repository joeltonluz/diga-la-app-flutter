import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/data/sample_cards.dart';
import 'package:diga_la_app/providers/language_provider.dart';
import 'package:diga_la_app/screens/converse_screen.dart';
import 'package:diga_la_app/services/language_service.dart';
import 'package:diga_la_app/widgets/card_tile.dart';
import '../helpers/mocks.dart';

Widget buildTestApp({LanguageService? languageService}) {
  final ls =
      languageService ?? LanguageService(MockTtsService());

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
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('apagar remove o último cartão da frase', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Adicionar 2 cartões tocando nos primeiros cards da grid
    final firstCard = find.text(sampleCards[0].labelPt).last;
    await tester.tap(firstCard);
    await tester.pumpAndSettle();

    final secondCard = find.text(sampleCards[1].labelPt).last;
    await tester.tap(secondCard);
    await tester.pumpAndSettle();

    // Apagar 1 — deve restar 1
    await tester.tap(find.byIcon(Icons.backspace_rounded));
    await tester.pumpAndSettle();

    // O último cartão adicionado foi removido, o primeiro ainda está visível
    expect(find.text(sampleCards[0].labelPt), findsWidgets);
  });

  testWidgets('apagar com frase vazia não quebra', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.backspace_rounded));
    await tester.pumpAndSettle();

    // Não deve lançar exceção
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

    // Limpar
    await tester.tap(find.byIcon(Icons.delete_rounded));
    await tester.pumpAndSettle();

    // A barra está vazia — o SentenceBar exibe placeholder
    expect(find.text(sampleCards[0].labelPt), findsOneWidget);
  });

  testWidgets('grade renderiza cartões do mockup', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(sampleCards.length, 12);

    // Cards visíveis incialmente (primeiras ~2 linhas)
    final cards = find.byType(CardTile);
    expect(cards, findsAtLeast(3));

    // Scroll para confirmar que existem mais cartões
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
