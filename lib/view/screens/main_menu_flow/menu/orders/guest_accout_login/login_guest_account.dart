import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/guest_accout_login/send_security_code.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class LoginGuestAccount extends StatefulWidget {
  const LoginGuestAccount({super.key});

  @override
  State<LoginGuestAccount> createState() => _LoginGuestAccountState();
}

class _LoginGuestAccountState extends State<LoginGuestAccount> {
  int selectedIndex = -1; // -1 means no selection

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
                  text: 'Do you have...',
                  size: 24,
                  color: kblack,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  paddingTop: 10,
                  paddingBottom: 20,
                ),
                SizedBox(
                  height: 94,
                  child: Row(
                    children: [
                      Expanded(
                        child: guest_login_container(
                          isSelected: selectedIndex == 0,
                          ontap: () {
                            setState(() {
                              selectedIndex = (selectedIndex == 0) ? -1 : 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: guest_login_container(
                          title: 'Your order number?',
                          img: Assets.imagesOrdernumb,
                          lineHeight: 1,
                          isSelected: selectedIndex == 1,
                          ontap: () {
                            setState(() {
                              selectedIndex = (selectedIndex == 1) ? -1 : 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                ///statechanging hadleing
                if (selectedIndex == 0) ...{
                  SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                    hint: 'Enter email',
                    label: 'Email',
                    bordercolor: ktransparent,
                    filledColor: kblack.withOpacity(0.06),
                  )
                }
              ],
            ),
          ),
          if (selectedIndex == 0)
            MyButton(
              buttonText: 'Send security code',
              mhoriz: 22,
              mBottom: Platform.isIOS ? 140 : 120, //120,
              onTap: () {
                Navigator.of(context).push(
                  CustomPageRoute(page: EnterSecurityCode()),
                );
                // Get.to(()=>EnterSecurityCode(),
                // );
              },
            )
        ],
      ),
    );
  }
}

class guest_login_container extends StatelessWidget {
  final String? title, img;
  final bool? isSelected;
  final double? lineHeight;
  final VoidCallback? ontap;
  const guest_login_container({
    super.key,
    this.title,
    this.img,
    this.isSelected,
    this.ontap,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: CustomeContainer(
        borderWidth: 2,
        borderColor: kgreen2,
        color: isSelected == true ? kgreen2 : ktransparent,
        radius: 8,
        vpad: 6,
        hpad: 6,
        widget: Column(
          children: [
            Image.asset(
              img ?? Assets.imagesEmail,
              width: 32,
              height: 32,
              color: isSelected == true ? kwhite : null,
            ),
            MyText(
              text: title ?? 'Your email?',
              size: 20,
              color: isSelected == true ? kwhite : kblack,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
              lineHeight: lineHeight,
            )
          ],
        ),
      ),
    );
  }
}
