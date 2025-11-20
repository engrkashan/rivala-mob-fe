import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/app_colors.dart';
import '../../generated/assets.dart';
import 'common_image_view_widget.dart';
import 'my_button.dart';
import 'my_text_widget.dart';

class DialogBoxes {
  static void showSuccessDialog(String title, String message,
      {String? ButtonText,
      String? button2text,
      bool? hasSecbutton = false,
      bool? hasbutton = true,
      Color? button2color,
      VoidCallback? ontap,
      VoidCallback? ontap2,
      String? image,
      Color? titleColor,
      double? hpadd}) {
    Get.dialog(
      AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: hpadd ?? 30.0),
        contentPadding: EdgeInsets.only(
            bottom: hasbutton == false ? 10 : 30, left: 5, right: 5),
        backgroundColor: kwhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            // if (image != null)
            CommonImageView(
              svgPath: image ?? Assets.imagesEmail,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            // Image.asset(
            //   image ?? Assets.imagesSuccess,
            //   width: 100,
            //   height: 100,
            // ),
            const SizedBox(height: 5),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text: title,
                color: titleColor ?? kblack,
                size: 20,
                weight: FontWeight.w800,
                paddingTop: 5,
              ),
              MyText(
                text: message,
                color: ktertiary,
                size: 14,
                weight: FontWeight.w400,
                paddingBottom: 20,
                textAlign: TextAlign.center,
              ),
              if (hasbutton == true)
                if (hasSecbutton == false)
                  MyButton(
                    onTap: ontap ?? Get.back,
                    buttonText: ButtonText ?? 'Back to Login',
                    fontSize: 14,
                  ),
              if (hasbutton == true && hasSecbutton == true)
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        onTap: ontap ?? Get.back,
                        buttonText: ButtonText ?? 'Back to Login',
                        fontSize: 14,
                        backgroundColor: kwhite,
                        outlineColor: ktertiary.withOpacity(0.4),
                        fontColor: ksecondary,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MyButton(
                        onTap: ontap2 ?? Get.back,
                        buttonText: button2text ?? 'Back to Login',
                        fontSize: 14,
                        backgroundColor: button2color ?? ksecondary,
                        height: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  static void showDialog({
    required String title,
    required BuildContext context,
    String? okButtonText,
    String? noButtonText,
    VoidCallback? okButtonTap,
  }) {
    Get.dialog(
        barrierDismissible: false,
        Center(
          child: Container(
            width: 270,
            height: 215,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                MyText(
                  text: title,
                  size: 15,
                  weight: FontWeight.w700,
                ),
                Divider(),
                TextButton(
                    onPressed: okButtonTap,
                    child: MyText(
                      text: okButtonText ?? "Yes",
                      size: 13,
                      color: Colors.deepOrange,
                    )),
                Divider(),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: MyText(
                      text: noButtonText ?? "No",
                      size: 13,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
        ));
  }
}
