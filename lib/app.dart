import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/high_contrast_provider.dart';
import 'screens/converse_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/saved_phrases_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: _AppContent(),
    );
  }
}

class _AppContent extends ConsumerWidget {
  const _AppContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highContrast = ref.watch(highContrastModeProvider);

    return MaterialApp(
      title: 'Diga Lá',
      theme: highContrast ? AppTheme.highContrast() : AppTheme.regular(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const HomeScreen(),
        '/converse': (context) => const ConverseScreen(),
        '/learn': (context) => const LearnScreen(),
        '/saved-phrases': (context) => const SavedPhrasesScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
