import 'package:alert_info/alert_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/screens/master_flow/auth/terms_conditions.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/rich_text.dart';

import '../../../../../controllers/providers/user/auth_provider.dart';
import 'create_linkss/create_links.dart';
import 'create_linkss/link_success.dart';
import 'discovery_matching/product_setup_success.dart';

class MasterVerifyAccount extends StatefulWidget {
  const MasterVerifyAccount({super.key});

  @override
  State<MasterVerifyAccount> createState() => _MasterVerifyAccountState();
}

class _MasterVerifyAccountState extends State<MasterVerifyAccount> {
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(
          context: context,
        ),
        backgroundColor: kwhite,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Image.asset(
                        Assets.imagesLogo1,
                        width: 64,
                        height: 64,
                      ),
                      MyText(
                        text: 'Verify your account',
                        size: 24,
                        weight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        paddingTop: 18,
                        paddingBottom: 100,
                      ),
                      MyText(
                        text:
                            'Please enter the verification code sent to your device',
                        color: ktertiary,
                        size: 14,
                        textAlign: TextAlign.center,
                        paddingBottom: 30,
                      ),
                      MyTextField(
                        controller: _otpController,
                        hint: 'Enter code',
                        useOutlinedBorder: true,
                        iscenter: true,
                        radius: 50,
                      ),
                      Texts(children: [TextSpan(text: '')]),
                      AuthBottomRow()
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomCheckBox(isActive: true, onTap: () {}),
                          SizedBox(
                            width: 5,
                          ),
                          AuthBottomRow(
                            size: 13,
                            text1: 'I agree to the terms and conditions. ',
                            text2: 'View',
                            ontap: () {
                              Get.to(() => TermsConditions());
                            },
                          )
                        ],
                      ),
                      Consumer<AuthProvider>(builder: (context, ref, _) {
                        return Mybutton2(
                          ontap: () async {
                            await ref.verifyEmail(
                                otp: _otpController.text.trim());

                            if (ref.error != null && ref.error!.isNotEmpty) {
                              AlertInfo.show(
                                context: context,
                                text: ref.error!,
                              );
                              return;
                            }

                            // ✅ OTP SUCCESS → NAVIGATE
                            Get.to(() => GradientSuccessScreen(
                                  title: 'Well done',
                                  desc: 'Now let’s select your theme.',
                                  buttontext: 'Choose your theme',
                                  ontap: () {
                                    Get.to(() => SelectTheme());
                                  },
                                  skipTap: () {
                                    Get.back();
                                    Get.to(() => GradientSuccessScreen(
                                          title: 'Well done!',
                                          desc: 'Now, let’s import your links.',
                                          buttontext: 'Import your links',
                                          ontap: () {
                                            Get.to(() => MasterCreateLink());
                                          },
                                          skipTap: () {
                                            Get.to(() => MAsterLinkSuccess());
                                          },
                                        ));
                                  },
                                ));
                          },
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
            if (context.read<AuthProvider>().isLoading)
              Positioned.fill(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ));
  }
}

class AuthBottomRow extends StatelessWidget {
  final String? text1, text2;
  final VoidCallback? ontap;
  final double? size;
  const AuthBottomRow({
    super.key,
    this.text1,
    this.text2,
    this.ontap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: text1 ?? 'Didn’t receive a code?  ',
              style: TextStyle(
                color: ktertiary,
                fontSize: size ?? 14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.poppins,
              ),
            ),
            TextSpan(
              text: text2 ?? 'Resend ',
              recognizer: TapGestureRecognizer()..onTap = ontap,
              style: TextStyle(
                shadows: [Shadow(color: ktertiary, offset: Offset(0, -3))],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                fontSize: 12,
                decorationColor: ktertiary,
                decorationThickness: 1,
                decorationStyle: TextDecorationStyle.solid,
                fontFamily: AppFonts.poppins,
                height: 1.4, // Adjusts spacing between text and underline
              ),
            ),
          ],
        ),
        textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: true,
        ),
      ),
    );
  }
}
