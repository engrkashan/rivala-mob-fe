import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';

class row_widget extends StatelessWidget {
  final String? icon, title;
  final Color? textColor, iconColor;
  final double? texSize, iconSize;
  final FontWeight? weight;
  final IconData? iconData;
  final VoidCallback? onTap;
  final bool isIconRight;
  final bool? useCustomFont;
  final FontStyle? fontstyle;
final TextDecoration? decoration;
  const row_widget({
    super.key,
    this.icon,
    this.title,
    this.textColor,
    this.texSize,
    this.iconData,
    this.iconColor,
    this.weight,
    this.iconSize,
    this.onTap,
    this.useCustomFont,
    this.isIconRight = false, this.decoration, this.fontstyle,
  });

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = (icon != null)
        ? Bounce(
            onPressed: onTap ?? () {},
            duration: const Duration(milliseconds: 200),
            child: Image.asset(
              icon ?? Assets.imagesGoogle,
              width: iconSize ?? 24,
              height: iconSize ?? 24,
              color: iconColor,
              fit: BoxFit.contain,
            ),
          )
        : (iconData != null)
            ? Icon(
                iconData ?? Icons.add,
                color: textColor,
                size: iconSize ?? 24,
              )
            : const SizedBox.shrink();

    final Widget textWidget = MyText(
      text: title ?? '10',
      color: textColor ?? kblack,
      size: texSize ?? 14,
      paddingLeft: isIconRight ? 0 : 5,
      paddingRight: isIconRight ? 5 : 0,
      weight: weight ?? FontWeight.w500,
      useCustomFont: useCustomFont,
      decoration: decoration??TextDecoration.none,
      fontStyle:fontstyle ,
      onTap: onTap,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          isIconRight ? [textWidget, iconWidget] : [iconWidget, textWidget],
    );
  }
}
