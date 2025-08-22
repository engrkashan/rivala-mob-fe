import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';


class CustomeContainer extends StatelessWidget {
  final Widget? widget;
  final Color? color, borderColor, shadowColor;
  final double? radius, vpad, hpad, mtop, height, width,mbott,borderWidth;
  final bool hasShadow;

  const CustomeContainer({
    super.key,
    this.widget,
    this.color,
    this.borderColor,
    this.shadowColor,
    this.radius,
    this.vpad,
    this.hpad,
    this.mtop,
    this.mbott,
    this.height,
    this.width,
    this.hasShadow = false, this.borderWidth, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: mtop ?? 0,bottom:mbott??0),
      padding: EdgeInsets.symmetric(vertical: vpad ?? 16, horizontal: hpad ?? 18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? 12),
        border: Border.all(color: borderColor ?? Colors.transparent,width: borderWidth??1),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: shadowColor ?? kgrey4,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: widget,
    );
  }
}


