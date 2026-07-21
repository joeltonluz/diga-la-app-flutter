import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/domain/entities/pictogram_card.dart';
import 'package:diga_la_app/widgets/sentence_bar.dart';

void main() {
  const card1 = PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧');
  const card2 = PictogramCard(id: 'b', labelPt: 'casa', labelEn: 'home', emoji: '🏠');

  Widget buildSentenceBar({
    required List<PictogramCard> cards,
    void Function(int index)? onCardTap,
    void Function(int oldIndex)? onMoveLeft,
    void Function(int index)? onMoveRight,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SentenceBar(
          cards: cards,
          onCardTap: onCardTap,
          onMoveLeft: onMoveLeft,
          onMoveRight: onMoveRight,
        ),
      ),
    );
  }

  testWidgets('empty bar shows placeholder text', (tester) async {
    await tester.pumpWidget(buildSentenceBar(cards: []));
    expect(find.text('Toque nos cartões para montar uma frase'), findsOneWidget);
  });

  testWidgets('bar with cards shows emoji and label', (tester) async {
    await tester.pumpWidget(buildSentenceBar(cards: [card1, card2]));
    expect(find.text('💧'), findsOneWidget);
    expect(find.text('água'), findsOneWidget);
    expect(find.text('🏠'), findsOneWidget);
    expect(find.text('casa'), findsOneWidget);
  });

  testWidgets('tapping card calls onCardTap with correct index', (tester) async {
    int? tappedIndex;
    await tester.pumpWidget(buildSentenceBar(
      cards: [card1, card2],
      onCardTap: (index) => tappedIndex = index,
    ));

    await tester.tap(find.text('água'));
    expect(tappedIndex, equals(0));
  });

  testWidgets('first card has no move-left button', (tester) async {
    await tester.pumpWidget(buildSentenceBar(
      cards: [card1, card2],
      onMoveLeft: (_) {},
      onMoveRight: (_) {},
    ));

    final leftChevrons = find.byIcon(Icons.chevron_left);
    expect(leftChevrons, findsOneWidget);
  });

  testWidgets('last card has no move-right button', (tester) async {
    await tester.pumpWidget(buildSentenceBar(
      cards: [card1],
      onMoveLeft: (_) {},
      onMoveRight: (_) {},
    ));

    expect(find.byIcon(Icons.chevron_left), findsNothing);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });

  testWidgets('move-left button calls onMoveLeft with correct index', (tester) async {
    int? movedIndex;
    await tester.pumpWidget(buildSentenceBar(
      cards: [card1, card2],
      onMoveLeft: (index) => movedIndex = index,
      onMoveRight: (_) {},
    ));

    final leftChevron = find.byIcon(Icons.chevron_left).last;
    await tester.tap(leftChevron);
    expect(movedIndex, equals(1));
  });

  testWidgets('move-right button calls onMoveRight with correct index', (tester) async {
    int? movedIndex;
    await tester.pumpWidget(buildSentenceBar(
      cards: [card1, card2],
      onMoveLeft: (_) {},
      onMoveRight: (index) => movedIndex = index,
    ));

    final rightChevron = find.byIcon(Icons.chevron_right).first;
    await tester.tap(rightChevron);
    expect(movedIndex, equals(0));
  });
}
