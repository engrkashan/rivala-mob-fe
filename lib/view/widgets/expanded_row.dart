import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';

import 'my_text_widget.dart';

class ExpandedRow extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? color1;
  final Color? color2;
  final FontWeight? weight1;
  final FontWeight? weight2;
  final double? size1;
  final bool? useCustomFont;
  final double? size2;
  final VoidCallback? ontap1, ontap2;
  final TextDecoration? decoration1, decoration2;
  const ExpandedRow({
    super.key,
    required this.text1,
    required this.text2,
    this.color1,
    this.color2,
    this.weight1,
    this.weight2,
    this.size1,
    this.size2,
    this.ontap2,
    this.ontap1,
    this.decoration1,
    this.decoration2,
    this.useCustomFont,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: text1, //'\$39.69',
          size: size1 ?? 12.5,
          color: color1 ?? kblack2,
          weight: weight1 ?? FontWeight.w500,
          onTap: ontap1,
          decoration: decoration1 ?? TextDecoration.none,
          useCustomFont: useCustomFont,
        ),
        MyText(
          text: text2, //'Free Now Booking Fee',
          size: size2 ?? 12.5,
          color: color2 ?? kblack2,
          weight: weight2 ?? FontWeight.w500,
          onTap: ontap2,
          decoration: decoration2 ?? TextDecoration.none,
          useCustomFont: useCustomFont,
        ),
      ],
    );
  }
}

enum ColumnAlignment { start, end, center }

class TwoTextedColumn extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? color1;
  final Color? color2;
  final FontWeight? weight1;
  final FontWeight? weight2;
  final double? size1;
  final double? size2, mBottom;
  final ColumnAlignment alignment;
  final bool? useCustomFont;
  final TextDecoration? decoration1, decoration2;
  final String? fontFamily;
  const TwoTextedColumn({
    super.key,
    required this.text1,
    required this.text2,
    this.color1,
    this.color2,
    this.weight1,
    this.weight2,
    this.size1,
    this.size2,
    this.alignment = ColumnAlignment.start,
    this.mBottom,
    this.decoration1,
    this.decoration2,
    this.fontFamily,
    this.useCustomFont,
  });

  @override
  Widget build(BuildContext context) {
    // Map alignment choice to CrossAxisAlignment
    final crossAxisAlignment = {
      ColumnAlignment.start: CrossAxisAlignment.start,
      ColumnAlignment.end: CrossAxisAlignment.end,
      ColumnAlignment.center: CrossAxisAlignment.center,
    }[alignment]!; // Use ! to ensure a non-null value

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        MyText(
          text: text1,
          size: size1 ?? 14,
          color: color1 ?? kblack2,
          weight: weight1 ?? FontWeight.w500,
          paddingBottom: mBottom ?? 3,
          decoration: decoration1 ?? TextDecoration.none,
          fontFamily: fontFamily ?? AppFonts.poppins,
          useCustomFont: useCustomFont,
        ),
        MyText(
          text: text2,
          size: size2 ?? 14,
          color: color2 ?? kblack2,
          weight: weight2 ?? FontWeight.w400,
          maxLines: 10,
          textOverflow: TextOverflow.ellipsis,
          decoration: decoration2 ?? TextDecoration.none,
          fontFamily: fontFamily ?? AppFonts.poppins,
          useCustomFont: useCustomFont,
        ),
      ],
    );
  }
}
