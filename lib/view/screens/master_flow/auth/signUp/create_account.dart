import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signIn/signin.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/verify_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class MasterCreateAccount extends StatefulWidget {
  const MasterCreateAccount({super.key});

  @override
  State<MasterCreateAccount> createState() => _MasterCreateAccountState();
}

class _MasterCreateAccountState extends State<MasterCreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(context: context,),
        backgroundColor: kwhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  Image.asset(
                    Assets.imagesLogo1,
                    width: 64,
                    height: 64,
                  ),
                  MyText(
                    text: 'Create your account',
                    size: 24,
                    weight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    paddingTop: 18,
                    paddingBottom: 40,
                  ),
                  signIn_opt_row(
                    delay: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  signIn_opt_row(
                      icon: Assets.imagesApple,
                      title: 'Sign in with Apple',
                      delay: 400),
                  SizedBox(
                    height: 10,
                  ),
                  signIn_opt_row(
                      icon: Assets.imagesMicrosoft,
                      title: 'Sign in with Microsoft',
                      delay: 600),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: ktertiary,
                      )),
                      MyText(
                        text: '  Or continue with phone number  ',
                        color: ktertiary,
                        size: 14,
                      ),
                      Expanded(
                          child: Divider(
                        color: ktertiary,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    hint: 'Enter Phone Number',
                    useOutlinedBorder: true,
                    iscenter: true,
                    radius: 50,
                  ),
                  MyText(
                    text: 'We will send you a one time code via SMS',
                    paddingTop: 15,
                    textAlign: TextAlign.center,
                    color: ktertiary,
                    size: 14,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
              child: CustomeContainer(
                vpad: 15,
                hpad: 15,
                height: 75,
                hasShadow: true,
                radius: 50,
                color: kwhite,
                widget: Row(
                  children: [
                    Expanded(
                        child: MyButton(
                      buttonText: 'Continue',
                      onTap: () {
                        Get.to(() => MasterVerifyAccount());
                      },
                    )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
