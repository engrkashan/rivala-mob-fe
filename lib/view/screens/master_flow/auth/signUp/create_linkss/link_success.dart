import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/discovery.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class MAsterLinkSuccess extends StatefulWidget {
  const MAsterLinkSuccess({super.key});

  @override
  State<MAsterLinkSuccess> createState() => _MAsterLinkSuccessState();
}

class _MAsterLinkSuccessState extends State<MAsterLinkSuccess> {
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
              text: 'Ta-Da!',
              size: 44,
              weight: FontWeight.w700,
              color: kwhite,
              textAlign: TextAlign.center,
              paddingTop: 200,
            ),
            MyText(
              text: 'Your Account is Done.',
              size: 24,
              weight: FontWeight.w400,
              color: kwhite,
              textAlign: TextAlign.center,
              paddingBottom: 1,
            ),
            Spacer(),
            MyButton(
              buttonText: 'Let’s populate your store!',
              mBottom: 0,
              onTap: () {
                Get.to(() => DiscoveryMatching());
              },
            ),
            Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: Bounce_widget(
                  ontap: () {

                     Get.to(()=>GradientSuccessScreen());
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
