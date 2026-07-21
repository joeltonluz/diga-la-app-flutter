import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';
import '../widgets/balo_widget.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _navigateToHome);
  }

  void _navigateToHome() {
    _timer?.cancel();
    if (!mounted) return;

    final disableAnimations = MediaQuery.of(context).disableAnimations;

    if (disableAnimations) {
      Navigator.pushReplacementNamed(context, '/');
      return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToHome,
      child: Scaffold(
        backgroundColor: DesignTokens.colors.surfaceScreen,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BaloWidget(size: 140, animation: BaloAnimation.breathing),
                const SizedBox(height: 16),
                Text(
                  'Diga Lá',
                  style: DesignTokens.textStyles.displayLarge.copyWith(
                    color: DesignTokens.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Comunicação que aproxima',
                  style: TextStyle(
                    fontFamily: DesignTokens.fontFamily,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: DesignTokens.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
