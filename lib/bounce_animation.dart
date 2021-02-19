import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {
  final Widget child;
  BounceAnimation({this.child});

  @override
  _BounceAnimationState createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
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
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(scale: _scale, child: widget.child),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
