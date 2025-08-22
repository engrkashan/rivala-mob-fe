import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class MasterOnboarding2 extends StatefulWidget {
  const MasterOnboarding2({super.key});

  @override
  State<MasterOnboarding2> createState() => _MasterOnboarding2State();
}

class _MasterOnboarding2State extends State<MasterOnboarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(gradient: konboardinggrad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  text: 'Let’s Help You Get Started.',
                  size: 44,
                  weight: FontWeight.w700,
                  color: kwhite,
                  textAlign: TextAlign.center,
                  paddingTop: 100,
                  paddingBottom: 80,
                ),
                Image.asset(
                  Assets.imagesLogo1,
                  width: 64,
                  height: 64,
                  color: kwhite,
                ),
              ],
            ),
          ),
          MyText(
            text: 'Rivala',
            size: 24,
            weight: FontWeight.w600,
            color: kwhite,
            textAlign: TextAlign.center,
            paddingBottom: 10,
          ),
          MyText(
            text: 'Copyright © 2023 Rivala. All Rights Reserved.',
            size: 12,
            weight: FontWeight.w400,
            color: kwhite,
            textAlign: TextAlign.center,
            paddingBottom: 48,
          ),
        ],
      ),
    ));
  }
}
