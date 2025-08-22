import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/nothing_t0_sell.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/discovery_animation.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class DiscoveryMatching extends StatefulWidget {
  const DiscoveryMatching({super.key});

  @override
  State<DiscoveryMatching> createState() => _DiscoveryMatchingState();
}

class _DiscoveryMatchingState extends State<DiscoveryMatching> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context, centerTitle: true, actions: [
          Bounce_widget(
            ontap: () {
              Get.to(() => GradientSuccessScreen());
            },
            widget: Text(
              'Skip',
              style: TextStyle(
                shadows: [Shadow(color: ktertiary, offset: Offset(0, -3))],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decorationColor: ktertiary,
                decorationThickness: 1,
                decorationStyle: TextDecorationStyle.solid,
                fontFamily: AppFonts.poppins,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          )
        ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  DiscoveryAnimation(),
                  MyText(
                      paddingTop: 40,
                      text: 'Do You Have Products to Sell on Rivala?',
                      size: 24,
                      paddingBottom: 30,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w600,
                      color: kblack2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(
                          child: buttonContainer(
                            text: 'Yes',
                            bgColor: ktransparent,
                            borderColor: ktertiary,
                            txtColor: ktertiary,
                            radius: 50,
                            vPadding: 12,
                            onTap: () {
                              Get.to(() => ProductSetup());
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: buttonContainer(
                            text: 'No',
                            bgColor: ktransparent,
                            borderColor: ktertiary,
                            txtColor: ktertiary,
                            radius: 50,
                            vPadding: 12,
                            onTap: () {
                              Get.to(() => NothingToSell());
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: buttonContainer(
                            text: 'Later',
                            bgColor: ktransparent,
                            borderColor: ktertiary,
                            txtColor: ktertiary,
                            radius: 50,
                            vPadding: 12,
                            onTap: () {
                              Get.to(() => NothingToSell());
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
