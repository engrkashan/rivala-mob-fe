import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/switch_button.dart';

import 'my_text_widget.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {this.label,
      required this.hint,
      required this.items,
      required this.selectedValue,
      required this.onChanged,
      this.mBottom,
      this.hasIcon,
      this.hintsize,
      this.iconSize,
      this.hpad,
      this.delay,
      this.bgColor,
      this.hasSwitch,
      this.bordercolor,
      this.iconPad,
      this.radius,
      this.useCustomFont,
      this.vpad});

  final List<dynamic> items;
  final String selectedValue;
  final ValueChanged<dynamic> onChanged;
  final String hint;
  final String? label;
  final Color? bgColor, bordercolor;
  final int? delay;
  double? mBottom, hintsize, iconSize, vpad, hpad, iconPad, radius;
  bool? hasIcon = false, hasSwitch = false, useCustomFont;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        MoveEffect(delay: Duration(milliseconds: delay ?? 100)),
        FadeEffect(duration: Duration(milliseconds: 300)),
        SlideEffect(delay: Duration(milliseconds: 200))
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: MyText(
                    text: label ?? '',
                    size: 15,
                    color: kblack,
                    weight: FontWeight.w500,
                    useCustomFont: useCustomFont,
                    paddingBottom: hasSwitch == true ? 0 : 8),
              ),
              if (hasSwitch == true)
                SwitchButton(
                  scale: 0.6,
                  isActive: true,
                )
            ],
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              items: items
                  .map(
                    (item) => DropdownMenuItem<dynamic>(
                      value: item,
                      child: MyText(
                        text: item,
                        size: 16,
                        color: kdarkTertiary,
                      ),
                    ),
                  )
                  .toList(),
              value: selectedValue,
              onChanged: onChanged,
              iconStyleData: IconStyleData(iconSize: 6),
              isDense: true,
              isExpanded: false,
              customButton: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: hpad ?? 16, vertical: vpad ?? 9),
                decoration: BoxDecoration(
                  color: bgColor ?? kblack.withOpacity(0.05),
                  border: Border.all(
                    color: bordercolor ?? ktransparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (hasIcon == true) Icon(Icons.flag),
                        MyText(
                          paddingLeft: 3,
                          text: selectedValue == hint ? hint : selectedValue,
                          size: hintsize ?? 12,
                          weight: FontWeight.w400,
                          color: selectedValue == hint ? ktertiary : ktertiary,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: iconPad ?? 5),
                      child: RotatedBox(
                        quarterTurns: 0,
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            size: iconSize ?? 20, color: ktertiary),
                      ),
                    ),
                  ],
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                elevation: 0,
                maxHeight: 300,
                offset: Offset(0, -10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kwhite,
                    border: Border.all(color: ktertiary.withOpacity(0.3))),
              ),
            ),
          ),
          SizedBox(
            height: mBottom ?? 15,
          )
        ],
      ),
    );
  }
}
