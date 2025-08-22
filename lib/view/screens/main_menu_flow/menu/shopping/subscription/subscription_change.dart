import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class SubscriptionChange extends StatelessWidget {
  final String? title, desc, appTitle;
  const SubscriptionChange({super.key, this.title, this.desc, this.appTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        context: context,
          title: appTitle ?? 'Pause Your Subscription',
          size: 18,
          centerTitle: true),
      backgroundColor: kwhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            Assets.imagesCheckmark,
            width: 80,
            height: 80,
          )),
          Center(
              child: MyText(
            text: title ?? 'Pause Confirmed',
            size: 24,
            color: kgreen,
            weight: FontWeight.w600,
            useCustomFont: true,
            paddingBottom: 10,
            paddingTop: 10,
          )),
          Center(
              child: MyText(
            text: desc ??
                'A confirmation email with your order details was sent to',
            size: 18,
            color: kbody,
            weight: FontWeight.w400,
            textAlign: TextAlign.center,
            paddingLeft: 22,
            paddingRight: 22,
            useCustomFont: true,
          )),
          Center(
              child: MyText(
                  text: 'janesmith@gmail.com',
                  size: 18,
                  color: kbody,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  useCustomFont: true,
                  // paddingLeft: 18,
                  // paddingRight: 18,
                  decoration: TextDecoration.underline)),
        ],
      ),
    );
  }
}
