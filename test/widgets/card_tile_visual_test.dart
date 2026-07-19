import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/domain/entities/pictogram_card.dart';
import 'package:diga_la_app/theme/design_tokens.dart';
import 'package:diga_la_app/widgets/card_tile.dart';

void main() {
  const testCard = PictogramCard(id: 'a', labelPt: 'agua', labelEn: 'water', emoji: '💧');

  Widget buildCardTile() {
    return MaterialApp(
      home: Scaffold(
        body: CardTile(card: testCard, onTap: () {}),
      ),
    );
  }

  testWidgets('CardTile uses border radius from theme tokens', (tester) async {
    await tester.pumpWidget(buildCardTile());

    final cardTileFinder = find.byType(CardTile);
    expect(cardTileFinder, findsOneWidget);

    final material = tester.widget<Material>(
      find.descendant(of: cardTileFinder, matching: find.byType(Material)),
    );
    expect(material.borderRadius, equals(DesignTokens.radii.card));
  });

  testWidgets('CardTile uses card label text style from theme', (tester) async {
    await tester.pumpWidget(buildCardTile());

    final label = tester.widget<Text>(find.text('agua'));
    expect(label.style?.fontFamily, 'Nunito');
    expect(label.style?.fontWeight, FontWeight.w700);
    expect(label.style?.fontSize, 17);
  });

  testWidgets('CardTile has minimum touch target of 80x80', (tester) async {
    await tester.pumpWidget(buildCardTile());

    final cardTileFinder = find.byType(CardTile);
    final container = tester.widget<Container>(
      find.descendant(of: cardTileFinder, matching: find.byType(Container)),
    );
    expect(container.constraints?.minWidth, 80);
    expect(container.constraints?.minHeight, 118);
  });
}
