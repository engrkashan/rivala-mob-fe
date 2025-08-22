//bounce
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class Bounce_widget extends StatelessWidget {
  final Widget widget;
  final int? duration;
  final VoidCallback? ontap;
  const Bounce_widget(
      {super.key, required this.widget, this.duration, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Bounce(
        child: widget,
        duration: Duration(milliseconds: duration ?? 200),
        onPressed: ontap??(){});
  }
}