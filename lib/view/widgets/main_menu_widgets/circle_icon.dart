import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';

class circular_icon_container extends StatelessWidget {
  final String? icon;
  final VoidCallback? ontap;
  final Color? bgColor,iconColor;
  final double? size,iconSize;
  const circular_icon_container({
    super.key, this.icon, this.ontap, this.bgColor, this.iconColor, this.size, this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
    widget: Container(
        width:size?? 56,
        height:size?? 56,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:bgColor?? kmenuGreen.withOpacity(0.09)),
        child: Center(
            child: Image.asset(
              color: iconColor,
         icon?? Assets.imagesBag,
          width:iconSize?? 28,
          height:iconSize?? 28,
        )),
      ),
    );
  }
}