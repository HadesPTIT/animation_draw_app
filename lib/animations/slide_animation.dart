// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SlideUpAnimation extends StatefulWidget {
  const SlideUpAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    super.key,
  });

  final Widget child;
  final Duration duration;

  @override
  _SlideUpAnimationState createState() => _SlideUpAnimationState();
}

class _SlideUpAnimationState extends State<SlideUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    offset = Tween(begin: Offset.zero, end: const Offset(0.0, 1.0))
        .animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: widget.child,
    );
  }
}
