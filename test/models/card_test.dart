import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/models/card.dart';

void main() {
  const card = Card(
    id: 'test',
    labelPt: 'água',
    labelEn: 'water',
    emoji: '💧',
  );

  test('card exposes labelPt and labelEn correctly', () {
    expect(card.labelPt, 'água');
    expect(card.labelEn, 'water');
  });

  test('card label defaults to labelPt', () {
    expect(card.label, 'água');
  });

  test('card exposes emoji and id', () {
    expect(card.emoji, '💧');
    expect(card.id, 'test');
  });
}
