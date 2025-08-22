import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SlideAnimation extends StatelessWidget {
  final int? delay;
  final Widget? child;
  const SlideAnimation({super.key, this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
           effects: [
     
        MoveEffect(delay: Duration(milliseconds: delay ?? 0)),
        FadeEffect(duration: Duration(milliseconds: 300)),
        SlideEffect(delay: Duration(milliseconds: 200))
      ],
      child: child??SizedBox(),
    );
  }
}