import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/create_links.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/customize_theme.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CustomizeThemeGradScreen extends StatefulWidget {
  const CustomizeThemeGradScreen({super.key});

  @override
  State<CustomizeThemeGradScreen> createState() => _CustomizeThemeGradScreenState();
}

class _CustomizeThemeGradScreenState extends State<CustomizeThemeGradScreen> {
  @override
  Widget build(BuildContext context) {
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
              text: 'Good choice!',
              size: 44,
              weight: FontWeight.w700,
              color: kwhite,
              textAlign: TextAlign.center,
              paddingTop: 200,
            ),
            MyText(
              text: 'Now, let’s customize it',
              size: 24,
              weight: FontWeight.w400,
              color: kwhite,
              textAlign: TextAlign.center,
              paddingBottom: 1,
            ),
            Spacer(),
            MyButton(
              buttonText: 'Customize your theme',
              mBottom: 0,
              onTap: () {
                Get.to(() => CustomizeTheme());
                //MasterCreateLink()
              },
            ),
            Spacer(),
            SizedBox()
          ],
        ),
      ),
    ));
  }
}
