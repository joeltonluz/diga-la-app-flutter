import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

const String _assetNeutral = 'assets/logo.png';
const String _assetBlinkBoth = 'assets/feelings/logo-blink-both.png';
const String _assetBlinkLeft = 'assets/feelings/logo-blink-left.png';
const String _assetBlinkRight = 'assets/feelings/logo-blink-right.png';

const List<String> _blinkAssets = [
  _assetBlinkBoth,
  _assetBlinkLeft,
  _assetBlinkRight,
];

const Duration _blinkDuration = Duration(milliseconds: 120);
const Duration _waveDuration = Duration(milliseconds: 3200);
const int _blinkIntervalMinSec = 4;
const int _blinkIntervalMaxSec = 15;

class BaloMascote extends StatefulWidget {
  final double size;
  final VoidCallback? onTap;

  const BaloMascote({
    super.key,
    this.size = 120,
    this.onTap,
  });

  @override
  BaloMascoteState createState() => BaloMascoteState();
}

class BaloMascoteState extends State<BaloMascote>
    with SingleTickerProviderStateMixin {
  String _currentAsset = _assetNeutral;
  AnimationController? _waveController;
  Animation<double>? _waveAnimation;
  Timer? _blinkTimer;
  Timer? _returnTimer;
  bool _waveCompleted = false;
  bool _animationsEnabled = true;
  bool _initialized = false;
  final Random _random = Random();

  String get currentAsset => _currentAsset;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final disable = MediaQuery.of(context).disableAnimations;
    _animationsEnabled = !disable;

    _precacheBlinkAssets();

    if (!_animationsEnabled) {
      _waveCompleted = true;
      return;
    }

    _startWave();
  }

  void _precacheBlinkAssets() {
    for (final asset in _blinkAssets) {
      precacheImage(AssetImage(asset), context);
    }
  }

  void _startWave() {
    _waveController = AnimationController(
      vsync: this,
      duration: _waveDuration,
    );

    _waveAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -0.5)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.5, end: 0.5)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 1,
      ),
    ]).animate(_waveController!);

    _waveController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _waveCompleted = true;
          _waveController?.dispose();
          _waveController = null;
          _waveAnimation = null;
        });
        _startBlinkCycle();
      }
    });

    _waveController!.forward();
  }

  void _startBlinkCycle() {
    _blinkTimer?.cancel();
    if (!_animationsEnabled || !_waveCompleted) return;

    final interval = _blinkIntervalMinSec +
        _random.nextInt(_blinkIntervalMaxSec - _blinkIntervalMinSec + 1);

    _blinkTimer = Timer(Duration(seconds: interval), _doBlink);
  }

  void _doBlink() {
    _returnTimer?.cancel();

    final blinkAsset = _blinkAssets[_random.nextInt(_blinkAssets.length)];
    setState(() {
      _currentAsset = blinkAsset;
    });

    _returnTimer = Timer(_blinkDuration, _returnToNeutral);
  }

  void _returnToNeutral() {
    _returnTimer = null;
    setState(() {
      _currentAsset = _assetNeutral;
    });
    _startBlinkCycle();
  }

  void triggerBlink() {
    if (!_animationsEnabled) return;
    _blinkTimer?.cancel();
    _doBlink();
  }

  void _onTap() {
    widget.onTap?.call();
    if (!_animationsEnabled) return;
    triggerBlink();
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _returnTimer?.cancel();
    _waveController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mascote = Image.asset(
      _currentAsset,
      width: widget.size,
      height: widget.size,
    );

    if (_waveAnimation != null) {
      mascote = AnimatedBuilder(
        animation: _waveAnimation!,
        builder: (context, child) =>
            Transform.rotate(angle: _waveAnimation!.value, child: child),
        child: mascote,
      );
    }

    return GestureDetector(
      key: const Key('balo_mascote_tap'),
      onTap: _onTap,
      child: mascote,
    );
  }
}
