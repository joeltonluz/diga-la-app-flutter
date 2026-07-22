import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/widgets/balo_mascote.dart';

Widget buildBaloMascote({
  double size = 120,
  VoidCallback? onTap,
  bool disableAnimations = false,
}) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(
        disableAnimations: disableAnimations,
      ),
      child: Scaffold(
        body: Center(
          child: BaloMascote(
            key: const Key('balo'),
            size: size,
            onTap: onTap,
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renderiza asset neutro (assets/logo.png)', (tester) async {
    await tester.pumpWidget(buildBaloMascote());

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));
    expect(state.currentAsset, equals('assets/logo.png'));
  });

  testWidgets('aceita tamanho customizado', (tester) async {
    await tester.pumpWidget(buildBaloMascote(size: 80));

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.width, equals(80.0));
    expect(image.height, equals(80.0));
  });

  testWidgets('piscada troca asset para um dos tres blink e retorna ao neutro',
      (tester) async {
    await tester.pumpWidget(buildBaloMascote());

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));

    state.triggerBlink();
    expect(
      state.currentAsset,
      anyOf('assets/feelings/logo-blink-both.png',
          'assets/feelings/logo-blink-left.png',
          'assets/feelings/logo-blink-right.png'),
    );

    await tester.pump(const Duration(milliseconds: 130));
    expect(state.currentAsset, equals('assets/logo.png'));
  });

  testWidgets('toque no balo dispara piscada imediata', (tester) async {
    await tester.pumpWidget(buildBaloMascote());

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));

    await tester.tap(find.byKey(const Key('balo')));
    expect(
      state.currentAsset,
      anyOf('assets/feelings/logo-blink-both.png',
          'assets/feelings/logo-blink-left.png',
          'assets/feelings/logo-blink-right.png'),
    );
  });

  testWidgets('toques consecutivos nao enfileiram piscadas', (tester) async {
    await tester.pumpWidget(buildBaloMascote());

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));

    state.triggerBlink();

    await tester.pump(const Duration(milliseconds: 30));

    state.triggerBlink();
    expect(state.currentAsset, isNot(equals('assets/logo.png')));

    await tester.pump(const Duration(milliseconds: 130));
    expect(state.currentAsset, equals('assets/logo.png'));
  });

  testWidgets('disableAnimations true: nenhuma piscada ao tocar',
      (tester) async {
    await tester.pumpWidget(buildBaloMascote(disableAnimations: true));

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));

    await tester.tap(find.byKey(const Key('balo')));
    expect(state.currentAsset, equals('assets/logo.png'));
  });

  testWidgets('timers sao cancelados no dispose', (tester) async {
    await tester.pumpWidget(buildBaloMascote());

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));
    state.triggerBlink();

    await tester.pump(const Duration(milliseconds: 30));

    addTearDown(() => {});
  });

  testWidgets('balanco inicial termina antes da primeira piscada',
      (tester) async {
    await tester.pumpWidget(buildBaloMascote());

    final state = tester.state<BaloMascoteState>(find.byKey(const Key('balo')));

    expect(state.currentAsset, equals('assets/logo.png'));

    await tester.pump(const Duration(seconds: 4));
    expect(state.currentAsset, equals('assets/logo.png'));

    state.triggerBlink();
    expect(
      state.currentAsset,
      anyOf('assets/feelings/logo-blink-both.png',
          'assets/feelings/logo-blink-left.png',
          'assets/feelings/logo-blink-right.png'),
    );
  });

  testWidgets('disableAnimations: onTap callback ainda eh chamado',
      (tester) async {
    int tapCount = 0;
    await tester.pumpWidget(buildBaloMascote(
      disableAnimations: true,
      onTap: () => tapCount++,
    ));

    await tester.tap(find.byKey(const Key('balo')));
    expect(tapCount, equals(1));
  });
}
