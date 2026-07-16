import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/app.dart';

void main() {
  testWidgets('App renders home screen without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Diga Lá'), findsOneWidget);
    expect(find.text('Conversar'), findsOneWidget);
    expect(find.text('Aprender'), findsOneWidget);
  });
}
