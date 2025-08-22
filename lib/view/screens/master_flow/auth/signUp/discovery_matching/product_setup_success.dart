import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/controller_instances.dart';
import 'package:rivala/controllers/image_picker_controller.dart';
import 'package:rivala/controllers/navbar_controller.dart';
import 'package:rivala/view/screens/master_flow/new_post/select_post_filters.dart';
import 'package:rivala/view/screens/persistent_bottom_nav_bar/persistant_bottom_navbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../widgets/image_picker_bottom_sheet.dart';
import '../../../../../widgets/image_picker_bottom_sheet_2.dart';

class GradientSuccessScreen extends StatelessWidget {
  final String? title, desc, buttontext;
  final VoidCallback? ontap, skipTap;
  final bool? hasSkip;
  final double? textSize;
  const GradientSuccessScreen(
      {super.key,
      this.title,
      this.desc,
      this.buttontext,
      this.ontap,
      this.skipTap,
      this.hasSkip = true,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagePickerController());
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(gradient: konboardinggrad),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: title ?? 'Woohoo!',
              size: textSize ?? 44,
              weight: FontWeight.w700,
              color: kwhite,
              textAlign: TextAlign.center,
              paddingTop: 200,
            ),
            MyText(
              text: desc ?? 'Now let’s create a post.',
              size: 24,
              weight: FontWeight.w400,
              color: kwhite,
              textAlign: TextAlign.center,
              paddingBottom: 1,
            ),
            Spacer(),
            MyButton(
              buttonText: buttontext ?? 'Create a post!',
              mBottom: 0,
              onTap: ontap ??
                  () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      builder: (_) {
                        return ImagePickerBottomSheet(
                          onCameraPick: () async {
                            Get.back();
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              builder: (_) {
                                return ImagePickerBottomSheet2(
                                  onCameraPick: () async {
                                    Get.back();
                                    controller.pickImageFromCamera();
                                  },
                                  onGalleryPick: () async {
                                    Get.back();
                                    controller.pickMultipleMedia();
                                  },
                                );
                              },
                            );
                          },
                          onGalleryPick: () async {
                            Get.back();
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              builder: (_) {
                                return ImagePickerBottomSheet2(
                                  onCameraPick: () async {
                                    Get.back();
                                    controller.pickVideoAndGenerateThumbnail(
                                        fromCamera: true);
                                  },
                                  onGalleryPick: () async {
                                    Get.back();
                                    controller.pickVideoAndGenerateThumbnail(
                                        fromCamera: false);
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );

                    //controller.pickFile();
                  },
            ),
            Spacer(),
            if (hasSkip == true)
              Align(
                  alignment: Alignment.bottomRight,
                  child: Bounce_widget(
                    ontap: skipTap ??
                        () {
                          navBarController.resetNavigatorKeys();
                          Get.offAll(() => PersistentBottomNavBar(),
                              binding: BindingsBuilder(() {
                            Get.put(BottomNavBarController());
                          }));
                        },
                    widget: MyText(
                      text: 'Skip >',
                      size: 15,
                      color: kwhite,
                      weight: FontWeight.w500,
                      textAlign: TextAlign.end,
                      paddingBottom: 50,
                    ),
                  ))
          ],
        ),
      ),
    ));
  }
}
