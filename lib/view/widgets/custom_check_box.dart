
import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';



// ignore: must_be_immutable
class CustomCheckBox extends StatelessWidget {
  CustomCheckBox(
      {Key? key,
      required this.isActive,
      required this.onTap,
      this.unSelectedColor,
      this.selectedColor,
      this.size,
      this.circleIcon,this.iconColor,
      this.radius,
      this.borderColor,
      this.bordercolor2,
      this.circleIconsize,
      this.iscircle})
      : super(key: key);

  final bool isActive;
  final VoidCallback onTap;
  Color? unSelectedColor, selectedColor,iconColor,borderColor,bordercolor2;
  bool? iscircle;
  final double? size,radius,circleIconsize;
  final IconData? circleIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 230,
        ),
        curve: Curves.easeInOut,
        height:size?? 20,
        width:size?? 20,
        decoration: BoxDecoration(
          color: isActive ? selectedColor ?? ksecondary :unSelectedColor ?? kwhite,
          border: Border.all(
            width: 1.0,
            color: isActive
                ?bordercolor2??ksecondary
                : borderColor?? ktertiary.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(iscircle == true ? 50 :radius?? 2),
        ),
        child: !isActive
            ? Icon(circleIcon,size: 16,color: kwhite,)?? SizedBox()
            : Icon(
              iscircle==true?circleIcon?? Icons.circle:  Icons.check,
                size:circleIconsize?? 16,
                color: isActive == true ?iconColor?? kwhite : kwhite,
              ),
      ),
    );
  }
}
