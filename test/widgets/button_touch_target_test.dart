import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/theme/app_theme.dart';

void main() {
  testWidgets('ElevatedButton renders and is tappable', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.regular(),
        home: const Scaffold(
          body: ElevatedButton(onPressed: null, child: Text('Test')),
        ),
      ),
    );

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('OutlinedButton renders and is tappable', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.regular(),
        home: const Scaffold(
          body: OutlinedButton(onPressed: null, child: Text('Test')),
        ),
      ),
    );

    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });
}
