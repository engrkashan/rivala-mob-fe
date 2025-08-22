import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/my_orders.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class EnterSecurityCode extends StatefulWidget {
  const EnterSecurityCode({super.key});

  @override
  State<EnterSecurityCode> createState() => _EnterSecurityCodeState();
}

class _EnterSecurityCodeState extends State<EnterSecurityCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context, title: ''),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                Image.asset(
                  Assets.imagesLogo1,
                  width: 76,
                  height: 64,
                ),
                MyText(
                  text: 'Enter the security code to view your order.',
                  size: 24,
                  color: kblack,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  paddingTop: 10,
                  paddingBottom: 20,
                ),
                MyTextField(
                  hint: 'Enter code',
                  label: 'Security code',
                  bordercolor: ktransparent,
                  filledColor: kblack.withOpacity(0.06),
                )
              ],
            ),
          ),
          MyButton(
            buttonText: 'Find my order',
            mhoriz: 22,
            mBottom: Platform.isIOS ? 140 : 120, //120,
            onTap: () {
              Navigator.of(context).push(
                CustomPageRoute(page: MyOrders()),
              );
              // Get.to(() => MyOrders());
            },
          )
        ],
      ),
    );
  }
}
