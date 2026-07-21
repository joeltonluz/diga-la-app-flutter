import 'package:flutter/material.dart';

enum BaloAnimation { none, breathing, wave, pulse }

class BaloWidget extends StatefulWidget {
  final double size;
  final BaloAnimation animation;
  final VoidCallback? onTap;
  final String? emptyMessage;

  const BaloWidget({
    super.key,
    this.size = 180,
    this.animation = BaloAnimation.none,
    this.onTap,
    this.emptyMessage,
  });

  @override
  BaloWidgetState createState() => BaloWidgetState();
}

class BaloWidgetState extends State<BaloWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool _hasWaved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _setupCurrentAnimation();
    });
  }

  @override
  void didUpdateWidget(BaloWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation != widget.animation) {
      _hasWaved = false;
      _setupCurrentAnimation();
    }
  }

  void _setupCurrentAnimation() {
    _controller?.dispose();
    _controller = null;
    _animation = null;

    if (widget.animation == BaloAnimation.none) {
      setState(() {});
      return;
    }

    final animationsEnabled = !MediaQuery.of(context).disableAnimations;
    if (!animationsEnabled) {
      setState(() {});
      return;
    }

    switch (widget.animation) {
      case BaloAnimation.breathing:
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        );
        _animation = Tween<double>(begin: 0.70, end: 1.70).animate(
          CurvedAnimation(parent: _controller!, curve: Curves.easeInOutSine),
        );
        _controller!.repeat(reverse: true);
        break;

      case BaloAnimation.wave:
        if (_hasWaved) return;
        _hasWaved = true;
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 3200),
        );
        _animation = TweenSequence<double>([
          // Centro (0.0) -> Esquerda (-2.0)
          TweenSequenceItem(
            tween: Tween(
              begin: 0.0,
              end: -0.5,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 1,
          ),
          // Esquerda (-2.0) -> Direita (0.0)
          TweenSequenceItem(
            tween: Tween(
              begin: -0.5,
              end: 0.5,
            ).chain(CurveTween(curve: Curves.easeInOut)),
            weight: 1,
          ),
          // Direita (2.0) -> Centro (0.0)
          TweenSequenceItem(
            tween: Tween(
              begin: 0.5,
              end: 0.0,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 1,
          ),
        ]).animate(_controller!);
        _controller!.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _animation = null;
              _controller?.dispose();
              _controller = null;
            });
          }
        });
        _controller!.forward();
        break;

      case BaloAnimation.pulse:
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1500),
        );
        _animation = Tween<double>(begin: 1.0, end: 1.35).animate(
          CurvedAnimation(parent: _controller!, curve: Curves.easeInOut),
        );
        _controller!.repeat(reverse: true);
        break;

      case BaloAnimation.none:
        break;
    }

    if (mounted) setState(() {});
  }

  void startPulse() {
    final animationsEnabled = !MediaQuery.of(context).disableAnimations;
    if (!animationsEnabled) return;

    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animation = null;
          _controller?.dispose();
          _controller = null;
        });
      }
    });
    _controller!.forward();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/logo.png',
      width: widget.size,
      height: widget.size,
    );

    if (_animation != null) {
      if (widget.animation == BaloAnimation.wave) {
        logo = AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) =>
              Transform.rotate(angle: _animation!.value, child: child),
          child: logo,
        );
      } else {
        logo = AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) =>
              Transform.scale(scale: _animation!.value, child: child),
          child: logo,
        );
      }
    }

    final widgetChildren = <Widget>[logo];

    if (widget.emptyMessage != null) {
      widgetChildren.add(const SizedBox(height: 12));
      widgetChildren.add(
        Text(
          widget.emptyMessage!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          ),
        ),
      );
    }

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: widgetChildren,
    );

    if (widget.onTap != null) {
      return GestureDetector(onTap: widget.onTap, child: column);
    }

    return column;
  }
}
