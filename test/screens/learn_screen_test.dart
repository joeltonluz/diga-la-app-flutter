import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diga_la_app/data/datasources/sample_categories.dart';
import 'package:diga_la_app/providers/language_provider.dart';
import 'package:diga_la_app/screens/category_grid_screen.dart';
import 'package:diga_la_app/screens/learn_screen.dart';
import 'package:diga_la_app/services/language_service.dart';
import '../helpers/mocks.dart';

Widget buildTestApp() {
  final tts = MockTtsService();
  final settings = InMemorySettingsRepository();
  final languageService = LanguageService(tts, settings);

  return ProviderScope(
    overrides: [
      languageServiceProvider.overrideWith((ref) => languageService),
    ],
    child: MaterialApp(
      home: const LearnScreen(),
      routes: {
        '/learn': (context) => const LearnScreen(),
      },
    ),
  );
}

void main() {
  testWidgets('grade contém todas as categorias esperadas', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    for (final category in sampleCategories) {
      await tester.scrollUntilVisible(
        find.text(category.name),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(category.name), findsOneWidget);
    }
  });

  testWidgets('tocar numa categoria navega para CategoryGridScreen', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(sampleCategories[0].name).last);
    await tester.pumpAndSettle();

    expect(find.byType(CategoryGridScreen), findsOneWidget);
  });

  testWidgets('título do AppBar é "Aprender"', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Aprender'), findsOneWidget);
  });

  testWidgets('GridView tem crossAxisCount igual a 2', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate
        as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.crossAxisCount, 2);
  });
}
