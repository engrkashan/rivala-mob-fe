import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/font_customisation/font_customization.dart';

class MyText extends StatefulWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final List<Shadow>? shadow;
  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;
  final bool? useCustomFont;

  MyText({
    Key? key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.shadow,
    this.fontStyle,
    this.useCustomFont = false,
  }) : super(key: key);

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    final FontController fontController = Get.find();

    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop!,
        left: widget.paddingLeft!,
        right: widget.paddingRight!,
        bottom: widget.paddingBottom!,
      ),
      child: GestureDetector(
          onTap: widget.onTap,
          child: Text(
            widget.text,
            style: TextStyle(
              shadows: widget.shadow,
              fontSize: widget.size ?? 12,
              color: widget.color ?? kblack2,
              fontWeight: widget.weight,
              decoration: widget.decoration,
              decorationColor: widget.color ?? kblack2,
              decorationThickness: 2,
              fontFamily: widget.useCustomFont == true
                  ? fontController.selectedFont.value 
                  : widget.fontFamily ?? AppFonts.poppins,
              height: widget.lineHeight,
              fontStyle: widget.fontStyle,
              letterSpacing: widget.letterSpacing ?? 0.5,
            ),
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            overflow: widget.textOverflow,
          ),
        ),
      
    );
  }
}

//
class MyGradientText extends StatelessWidget {
  MyGradientText(
      {Key? key,
      required this.text,
      this.size,
      this.fontFamily,
      this.gradient = kgradmainmenu,
      this.ontap,
      this.decorationn,
      this.length, this.weight})
      : super(key: key);

  final String text;
  final FontWeight? weight;
  final double? size, length;
  final VoidCallback? ontap;
  final String? fontFamily;
  final Gradient gradient;
  final TextDecoration? decorationn;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return gradient.createShader(bounds);
        },
        child: MyText(
          text: text,
          onTap: ontap,
          size: size ?? 12,
          color: kwhite,
          weight: weight,
          decoration: decorationn ?? TextDecoration.none,
          lineHeight: length,
        ));
  }
}