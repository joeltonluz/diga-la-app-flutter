import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/converse_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Diga Lá',
        theme: AppTheme.regular(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/converse': (context) => const ConverseScreen(),
          '/learn': (context) => const LearnScreen(),
        },
      ),
    );
  }
}
