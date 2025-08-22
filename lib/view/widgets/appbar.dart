import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';


import 'my_text_widget.dart';

AppBar simpleAppBar({
  String? title,
  subtitle,
  leadingIcon,
  Widget? title2,
  double? size,
  VoidCallback? onBackIconTap,
  Color? bgColor,
  Color? contentColor,
  bool chooseChild = false,
  bool hasNonTextedTitle = false,
  bool haveBackButton = true,
  bool centerTitle = false,
  List<Widget>? actions,
  required BuildContext context,
  bool useCustomFont=false
}) {
  return AppBar(
   
    backgroundColor: bgColor ?? kwhite,
    surfaceTintColor: bgColor ?? kwhite,
    centerTitle: centerTitle,
    iconTheme: IconThemeData(
      color: Colors.transparent,
    ),
    leadingWidth: haveBackButton ? 40 : 0,
    leading: haveBackButton
        ? GestureDetector(
            onTap: onBackIconTap ??
                () {
                  Navigator.pop(context);
                     // Get.back();
                },
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: 
                  Image.asset(
                 leadingIcon ??   Assets.imagesBackicon1,
                    height: 40,
                    width: 40,
                    //color: contentColor,
                  ),
            ),
          )
        : null,
    title: hasNonTextedTitle == true
        ? title2
        :
        //  Text(title??'',style: GoogleFonts.outfit(
        //   fontSize: 16,
        //   fontWeight: FontWeight.w600,
        //   color: kwhite
        // ),),
        MyText(
          useCustomFont: useCustomFont,
            text: title ?? '',
            size: size ?? 20,
            weight: FontWeight.w600,
            color: contentColor ?? ksecondary,
          ),
    actions: actions ?? [
        Bounce_widget(
          ontap: () {
                Get.back();
          },
            widget: Image.asset(
              Assets.imagesClose,
              width: 22,
              height: 22,
            ),
          ),
          SizedBox(width: 12,)
    ],
  );
}

///

AppBar simpleAppBar2({
  String? title,
  subtitle,
  leadingIcon,
  Widget? title2,
  double? size,
  VoidCallback? onBackIconTap,
  onAvatarTap,
  Color? bgColor,
  Color? contentColor,
  bool chooseChild = false,
  bool hasNonTextedTitle = false,
  bool haveBackButton = true,
  bool centerTitle = false,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: bgColor ?? kwhite,
    surfaceTintColor: kwhite,
    centerTitle: centerTitle,
    iconTheme: IconThemeData(
      color: Colors.transparent,
    ),
    leadingWidth: haveBackButton ? 40 : 0,
    leading: haveBackButton
        ? GestureDetector(
            onTap: onBackIconTap ?? () => Get.back(),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Image.asset(
                leadingIcon ?? Assets.imagesBackicon1,
                height: 35,
                width: 35,
                color: contentColor,
              ),
            ),
          )
        : null,
    title: hasNonTextedTitle == true
        ? title2 ??
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: subtitle ?? 'Your location',
                        color: kwhite,
                        size: 12,
                        weight: FontWeight.w400,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Assets.imagesGoogle,
                            width: 16,
                            height: 16,
                          ),
                          MyText(
                            text: title ?? 'New York, USA',
                            color: kwhite,
                            size: 14,
                            weight: FontWeight.w400,
                            paddingLeft: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.bottomSheet(ParentViewStudents(),
                              //     isScrollControlled: true);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: kwhite,
                              size: 22,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
       
                
              ],
            )
        : MyText(
            text: title ?? '',
            size: size ?? 18,
            weight: FontWeight.w600,
            color: contentColor ?? kblack,
          ),
    actions: actions ?? [],
  );
}

////

class ContainerAppbar extends StatelessWidget {
  final bool? isCenter,useCustomFont;
  final String? title,icon;
  final Color? textColor;
  const ContainerAppbar({super.key, this.isCenter=false, this.title, this.useCustomFont=false, this.textColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return isCenter==true?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounce_widget(
                                   ontap: (){
                                    Get.back();
                              },
                                widget: Image.asset(
                             Assets.imagesBackicon1,
                              width: 20,
                              color: kheader,
                              
                            )),
                            MyText(
                              text:title?? 'New Collection',
                              size: 16,
                              color:textColor?? kheader,
                              weight: FontWeight.w600,
                              useCustomFont: useCustomFont,
                            ),
                           Bounce_widget(
                                   ontap: (){
                                    Get.back();
                              },
                                widget: Image.asset(
                            icon?? Assets.imagesClose,
                              width: 23,
                              color:textColor?? kheader,
                              
                            )),
                          ],
                        ): Row(
                          children: [
                            Expanded(
                                child: MyText(
                              text:title?? 'Add product to my storefront',
                              size: 16,
                              color:textColor?? kheader,
                              weight: FontWeight.w600,
                              useCustomFont: true,
                            )),
                          Bounce_widget(
                                   ontap: (){
                                    Get.back();
                              },
                                widget: Image.asset(
                          icon??   Assets.imagesClose,
                              width: 23,
                              color:textColor?? kheader,
                              
                            )),
                          ],
                        );
  }
}