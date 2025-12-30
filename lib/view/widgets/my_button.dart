import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/follow_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:share_plus/share_plus.dart';

import 'my_text_widget.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    this.onTap,
    this.width,
    this.buttonText,
    this.height = 41,
    this.backgroundColor,
    this.fontColor,
    this.fontSize = 14,
    this.outlineColor = Colors.transparent,
    this.radius = 30,
    this.svgIcon,
    this.isleft = false,
    this.hasgrad = false,
    this.mBottom = 0,
    this.mhoriz = 0,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.image,
    this.iconSize = 24,
    this.iconPosition = IconPosition.left,
    this.imgColor,
    this.cornerIcon = false,
    this.useCustomFont = false,
  });

  final String? buttonText;
  final VoidCallback? onTap;
  final double? height, width;
  final double radius;
  final double fontSize;
  final Color outlineColor;
  final Color? imgColor;
  bool? isleft, hasgrad, cornerIcon, useCustomFont;

  final Color? backgroundColor, fontColor;
  final String? svgIcon;
  final IconData? icon;
  final String? image;
  final double iconSize;
  final IconPosition iconPosition;

  final double mhoriz, mBottom;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [ShimmerEffect(duration: Duration(milliseconds: 300))],
      child: Bounce(
        duration: Duration(milliseconds: 200),
        onPressed: onTap ?? () {},
        child: Container(
          margin: EdgeInsets.only(left: mhoriz, right: mhoriz, bottom: mBottom),
          height: height,
          width: width,
          decoration: hasgrad == true
              ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ksecondary, ksecondary],
                    stops: [0, 0.4],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(color: outlineColor),
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                      color: ksecondary.withOpacity(0.05),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, -1),
                    ),
                  ],
                )
              : BoxDecoration(
                  color: backgroundColor ?? kblack2,
                  border: Border.all(color: outlineColor),
                  borderRadius: BorderRadius.circular(radius),
                ),
          child: Align(
            alignment: isleft == true ? Alignment.centerLeft : Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: cornerIcon == true
                  ? MainAxisAlignment.spaceBetween // ✅ Moves icon to corner
                  : (isleft == true
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center),
              children: [
                if (icon != null && iconPosition == IconPosition.left)
                  Padding(
                    padding: EdgeInsets.only(
                        left: cornerIcon == true
                            ? 10.0
                            : 8.0), // ✅ Adjust for corners
                    child: Icon(icon, color: fontColor, size: iconSize),
                  ),
                if (image != null && iconPosition == IconPosition.left)
                  Padding(
                    padding:
                        EdgeInsets.only(left: cornerIcon == true ? 10.0 : 8.0),
                    child:
                        Image.asset(image!, height: iconSize, width: iconSize),
                  ),
                if (buttonText != null)
                  MyText(
                    useCustomFont: useCustomFont,
                    text: buttonText!,
                    size: fontSize,
                    color: fontColor ?? kwhite,
                    weight: fontWeight,
                    paddingLeft: isleft == true ? 10 : 0,
                  ),
                if (icon != null && iconPosition == IconPosition.right)
                  Padding(
                    padding: EdgeInsets.only(
                        right: cornerIcon == true
                            ? 10.0
                            : 8.0), // ✅ Adjust for corners
                    child: Icon(icon, color: fontColor, size: iconSize),
                  ),
                if (image != null && iconPosition == IconPosition.right)
                  Padding(
                    padding:
                        EdgeInsets.only(right: cornerIcon == true ? 10.0 : 8.0),
                    child:
                        Image.asset(image!, height: iconSize, width: iconSize),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum IconPosition { left, right }

//

class Mybutton2 extends StatelessWidget {
  final String? buttonText, buttonText2;
  final VoidCallback? ontap, ontap2;
  final double? mbot, hpad;
  final Color? bgColor, borderColor, fontColor;
  final bool? useCustomFont;
  const Mybutton2(
      {super.key,
      this.buttonText,
      this.ontap,
      this.mbot,
      this.hpad,
      this.buttonText2,
      this.ontap2,
      this.useCustomFont = false,
      this.bgColor,
      this.borderColor,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hpad ?? 0),
      child: CustomeContainer(
        mbott: mbot ?? 0,
        vpad: 15,
        hpad: 15,
        height: 75,
        hasShadow: true,
        radius: 50,
        color: kwhite,
        widget: Row(
          children: [
            if (buttonText2 != null) ...{
              Expanded(
                  child: MyButton(
                buttonText: buttonText2 ?? 'Create account',
                outlineColor: borderColor ?? kblack,
                fontColor: fontColor ?? kblack,
                backgroundColor: bgColor ?? ktransparent,
                useCustomFont: useCustomFont,
                onTap: ontap2 ??
                    () {
                      // Get.to(()=>MasterCreateAccount());
                    },
              )),
              SizedBox(
                width: 6,
              ),
            },
            Expanded(
                child: MyButton(
              backgroundColor: bgColor,
              outlineColor: borderColor ?? ktransparent,
              fontColor: fontColor,
              useCustomFont: useCustomFont,
              buttonText: buttonText ?? 'Continue',
              onTap: ontap ?? () {},
            )),
          ],
        ),
      ),
    );
  }
}

//
class Store_Button_Row extends StatelessWidget {
  final String? brandId;
  const Store_Button_Row({
    super.key,
    this.brandId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      mbott: 20,
      vpad: 15,
      hpad: 15,
      height: 75,
      hasShadow: true,
      shadowColor: kblack2.withOpacity(0.2),
      radius: 50,
      color: kwhite,
      widget: Row(
        children: [
          Expanded(
            child: Consumer<FollowProvider>(
              builder: (context, ref, _) {
                final followed = ref.isFollowed(brandId!);
                return MyButton(
                  buttonText: followed ? "Unfollow" : "Follow",
                  outlineColor: kbutton,
                  fontColor: kbutton,
                  fontSize: 13,
                  useCustomFont: true,
                  backgroundColor: ktransparent,
                  onTap: () async {
                    if (followed) {
                      await ref.unfollowBrand(brandId!);
                    } else {
                      await ref.followBrand(brandId!);
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
              child: MyButton(
            fontSize: 13,
            backgroundColor: kbutton,
            fontColor: kbuttonText,
            buttonText: 'Share profile',
            useCustomFont: true,
            onTap: () {
              Share.share(
                  'Check out this awesome store on Rivala! https://rivala.app/store/$brandId');
            },
          )),
          SizedBox(
            width: 5,
          ),
          Bounce_widget(
              widget: Image.asset(
            Assets.imagesLinkgrad,
            width: 44,
            height: 44,
          ))
        ],
      ),
    );
  }
}
