import 'package:flutter/material.dart' hide Card;
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/models/card.dart';
import 'package:diga_la_app/theme/design_tokens.dart';
import 'package:diga_la_app/widgets/sentence_bar.dart';

void main() {
  Widget buildSentenceBar({List<Card> cards = const []}) {
    return MaterialApp(
      home: Scaffold(
        body: SentenceBar(cards: cards),
      ),
    );
  }

  testWidgets('SentenceBar uses border radius from theme tokens', (tester) async {
    await tester.pumpWidget(buildSentenceBar());

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.borderRadius, equals(const BorderRadius.all(Radius.circular(20))));
  });

  testWidgets('SentenceBar uses soft border color from theme', (tester) async {
    await tester.pumpWidget(buildSentenceBar());

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    final borderColor = (decoration.border as Border).top.color;
    expect(borderColor, equals(DesignTokens.colors.borderSoft));
  });
}
