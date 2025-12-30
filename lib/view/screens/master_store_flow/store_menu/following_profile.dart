import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../models/store_model.dart';

class FollowerMaiProfile extends StatefulWidget {
  final StoreModel? store;
  const FollowerMaiProfile({super.key, this.store});

  @override
  State<FollowerMaiProfile> createState() => _FollowerMaiProfileState();
}

class _FollowerMaiProfileState extends State<FollowerMaiProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommonImageView(
          // imagePath: Assets.imagesNutritionbg,
          url: widget.store?.logoUrl,
          height: Get.height,
          width: Get.width,
        ),
        Scaffold(
          backgroundColor: ktransparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Bounce_widget(
                    ontap: () {
                      Navigator.pop(context);
                    },
                    widget: Image.asset(
                      Assets.imagesBack2,
                      width: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              CommonImageView(
                // imagePath: Assets.imagesNutrition,
                url: widget.store?.logoUrl,
                width: 80,
                height: 80,
                radius: 100,
              ),
              MyText(
                text: widget.store?.name ?? 'Nutrition Rescue',
                color: kwhite,
                size: 22,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
                useCustomFont: true,
              ),
              MyText(
                text: '@${widget.store?.owner?.username}',
                color: kwhite,
                size: 12,
                weight: FontWeight.w400,
                paddingBottom: 8,
                useCustomFont: true,
              ),
              MyText(
                paddingTop: 15,
                text: "${widget.store?.owner?.bio}",
                // 'Nutritionally-optimized meals for chronically malnourished children',
                color: kwhite,
                size: 12,
                paddingLeft: 18,
                paddingRight: 18,
                textAlign: TextAlign.center,
                weight: FontWeight.w400,
                paddingBottom: 15,
                useCustomFont: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buttonContainer(
                        text: '${widget.store?.followers.length}   Followers',
                        bgColor: ksecondary.withOpacity(0.2),
                        txtColor: kwhite,
                        textsize: 11,
                        hPadding: 30,
                        vPadding: 7,
                        useCustomFont: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buttonContainer(
                        text: '${widget.store?.followings.length}   Following',
                        bgColor: ksecondary.withOpacity(0.2),
                        txtColor: kwhite,
                        textsize: 11,
                        hPadding: 30,
                        vPadding: 7,
                        useCustomFont: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: Platform.isIOS ? 120 : 100,
            ),
            child: Store_Button_Row(brandId: widget.store?.id),
          ),
        )
      ],
    );
  }
}
