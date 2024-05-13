import 'package:flutter/material.dart';

enum FadeType {
  fadeIn,
  fadeOut,
}

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    required this.child,
    this.fadeType = FadeType.fadeIn,
    this.curve = Curves.fastOutSlowIn,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    super.key,
  });

  final Widget child;
  final FadeType fadeType;
  final Curve curve;
  final Duration duration;
  final Duration delay;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _hidden = false;

  bool get _hide =>
      _hidden || _controller.isCompleted && widget.fadeType == FadeType.fadeOut;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurveTween(curve: widget.curve).animate(_controller);

    // only hide when fading in (with a delay)
    _hidden =
        widget.fadeType == FadeType.fadeIn && widget.delay != Duration.zero;

    Future<void>.delayed(widget.delay).then((_) {
      if (mounted) {
        _hidden = false;
        _controller.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => _hide
          ? const SizedBox()
          : Opacity(
              opacity: widget.fadeType == FadeType.fadeIn
                  ? _animation.value
                  : 1 - _animation.value,
              child: child,
            ),
      child: widget.child,
    );
  }
}
