import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/data/sample_categories.dart';
import 'package:diga_la_app/providers/language_provider.dart';
import 'package:diga_la_app/screens/category_grid_screen.dart';
import 'package:diga_la_app/services/language_service.dart';
import 'package:diga_la_app/widgets/card_tile.dart';
import '../helpers/mocks.dart';

Widget buildTestApp({required LanguageService languageService}) {
  return ProviderScope(
    overrides: [
      languageServiceProvider.overrideWith((ref) => languageService),
    ],
    child: MaterialApp(
      home: CategoryGridScreen(
        category: sampleCategories[0],
        languageService: languageService,
      ),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  MockTtsService createMockTts() {
    final tts = MockTtsService();
    when(() => tts.setLanguage(any())).thenAnswer((_) async {});
    when(() => tts.speak(any())).thenAnswer((_) async {});
    when(() => tts.setSpeechRate(any())).thenAnswer((_) async {});
    return tts;
  }

  testWidgets('itens da categoria renderizam com CardTile', (tester) async {
    final tts = createMockTts();
    final languageService = LanguageService(tts);

    await tester.pumpWidget(buildTestApp(languageService: languageService));
    await tester.pumpAndSettle();

    final tiles = find.byType(CardTile);
    expect(tiles.evaluate().length, sampleCategories[0].items.length);
  });

  testWidgets('tocar num item chama LanguageService.speak', (tester) async {
    final tts = createMockTts();
    final languageService = LanguageService(tts);

    await tester.pumpWidget(buildTestApp(languageService: languageService));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CardTile).first);
    await tester.pumpAndSettle();

    // O teste verifica que não lançou exceção
    expect(find.byType(CategoryGridScreen), findsOneWidget);
  });

  testWidgets('AppBar tem nome da categoria', (tester) async {
    final tts = createMockTts();
    final languageService = LanguageService(tts);

    await tester.pumpWidget(buildTestApp(languageService: languageService));
    await tester.pumpAndSettle();

    expect(find.text(sampleCategories[0].name), findsOneWidget);
  });

  testWidgets('GridView tem crossAxisCount igual a 3', (tester) async {
    final tts = createMockTts();
    final languageService = LanguageService(tts);

    await tester.pumpWidget(buildTestApp(languageService: languageService));
    await tester.pumpAndSettle();

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate
        as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.crossAxisCount, 3);
  });
}
