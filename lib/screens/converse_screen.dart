import 'package:flutter/material.dart';

class ConverseScreen extends StatelessWidget {
  const ConverseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Conversar'),
      ),
      body: const Center(
        child: Text('Modo Conversar — em breve'),
      ),
    );
  }
}
