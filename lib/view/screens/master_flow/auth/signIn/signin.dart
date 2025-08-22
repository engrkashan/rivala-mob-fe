import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_account.dart';
import 'package:rivala/view/screens/persistent_bottom_nav_bar/persistant_bottom_navbar.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class MasterSignIn extends StatefulWidget {
  const MasterSignIn({super.key});

  @override
  State<MasterSignIn> createState() => _MasterSignInState();
}

class _MasterSignInState extends State<MasterSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(context: context,haveBackButton: false),
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
                    text: 'Sign in to Rivala',
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
                    delay: 400
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  signIn_opt_row(
                    icon: Assets.imagesMicrosoft,
                    title: 'Sign in with Microsoft',
                    delay: 600
                  ),
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
            Mybutton2(
              hpad: 12,
              mbot: 24,
              buttonText2: 'Create account',
              ontap2: (){    Get.to(()=>MasterCreateAccount());},
              buttonText: 'Sign in',
              ontap: () {
                 Get.offAll(() => PersistentBottomNavBar());
              },
            ),
      
          ],
        ));
  }
}

class signIn_opt_row extends StatelessWidget {
  final String? icon, title;
  final int? delay;
  const signIn_opt_row({
    super.key,
    this.icon,
    this.title, this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: [MoveEffect(delay: Duration(milliseconds: delay??500))],
      child: Bounce_widget(
        widget: CustomeContainer(
          height: 55,
          mtop: 0,
          radius: 50,
          color: kgrey2,
          widget: Row(
            children: [
              Image.asset(
                icon ?? Assets.imagesGoogle,
                width: 24,
                height: 24,
              ),
              Expanded(
                child: MyText(
                  text: title ?? 'Sign in with Google',
                  size: 14,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  //paddingTop: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
