import 'package:flutter/material.dart' hide Card;
import 'package:flutter_test/flutter_test.dart' hide Card;
import 'package:diga_la_app/models/card.dart';
import 'package:diga_la_app/widgets/sentence_bar.dart';

void main() {
  const card1 = Card(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧');
  const card2 = Card(id: 'b', labelPt: 'casa', labelEn: 'home', emoji: '🏠');

  Widget buildSentenceBar(List<Card> cards) {
    return MaterialApp(
      home: Scaffold(
        body: SentenceBar(cards: cards),
      ),
    );
  }

  testWidgets('empty bar shows placeholder text', (tester) async {
    await tester.pumpWidget(buildSentenceBar([]));
    expect(find.text('Toque nos cartões para montar sua frase'), findsOneWidget);
  });

  testWidgets('bar with cards shows emoji and label', (tester) async {
    await tester.pumpWidget(buildSentenceBar([card1, card2]));
    expect(find.text('💧'), findsOneWidget);
    expect(find.text('água'), findsOneWidget);
    expect(find.text('🏠'), findsOneWidget);
    expect(find.text('casa'), findsOneWidget);
  });
}
