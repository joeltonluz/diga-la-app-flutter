import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tts_provider.dart';

class TempTtsButton extends ConsumerWidget {
  const TempTtsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tts = ref.read(ttsServiceProvider);

    return ElevatedButton.icon(
      onPressed: () => tts.speak('Olá'),
      icon: const Icon(Icons.volume_up),
      label: const Text('🔊 Testar TTS'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

// TEMPORÁRIO: Este botão é apenas para testar o TTS durante o desenvolvimento.
// Deve ser removido assim que a grade de cartões (card-grid-tts) estiver pronta.
