import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:slide_action/slide_action.dart';

class SimpleExample extends StatelessWidget {
  const SimpleExample({
    this.rightToLeft = false,
    this.callback,
    this.stretchThumb = false,
    this.resetCurve = Curves.easeOut,
    this.resetDuration = const Duration(milliseconds: 400),
    this.thumbWidth,
    this.trackHeight = 64,
    Key? key,
  }) : super(key: key);
  final bool rightToLeft;
  final FutureOr<void> Function()? callback;
  final bool stretchThumb;
  final Curve resetCurve;
  final Duration resetDuration;
  final double? thumbWidth;
  final double trackHeight;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: SlideAction(
        trackHeight: trackHeight,
        snapAnimationCurve: resetCurve,
        snapAnimationDuration: resetDuration,
        stretchThumb: stretchThumb,
        thumbWidth: thumbWidth,
        rightToLeft: rightToLeft,
        trackBuilder: (context, state) {
          return Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xffEDF2F5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: MyText(
              text: "Buy Now",
              weight: FontWeight.bold,
               useCustomFont: true,
           //   paddingLeft: 22,
              size: 9,
              textAlign: TextAlign.end,
            ),
          );
        },
        thumbBuilder: (context, state) {
          return Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: stretchThumb ? 70 : double.infinity,
              child: Center(
                child:Image.asset(Assets.imagesBuy,width: 38,height: 38,)
              ),
            ),
          );
        },
        action: callback,
      ),
    );
  }
}