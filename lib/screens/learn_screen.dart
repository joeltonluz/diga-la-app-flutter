import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Aprender'),
      ),
      body: const Center(
        child: Text('Modo Aprender — em breve'),
      ),
    );
  }
}
