import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/set_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class ManagePersonalInfo extends StatefulWidget {
  const ManagePersonalInfo({super.key});

  @override
  State<ManagePersonalInfo> createState() => _ManagePersonalInfoState();
}

class _ManagePersonalInfoState extends State<ManagePersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context,title: 'Personal Info', centerTitle: true, actions: [
          Bounce_widget(
              widget: Image.asset(
            Assets.imagesClose,
            width: 18,
            height: 18,
          )),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  EditImgStack(),
                  SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                    hint: 'Austin Larsen',
                    label: 'Name',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 200,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  MyTextField(
                    hint: '@austinlarsen27',
                    label: 'Handle',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 400,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  MyTextField(
                    hint: 'austinlarsen27@gmail.com',
                    label: 'Email Address',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 600,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  MyTextField(
                    hint: '123 W Buffalo Dr., Saratoga Springs, NY',
                    label: 'Address',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 800,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  CustomDropDown(
                    label: 'Gender',
                    delay: 1000,
                      hint: '(Optional)',
                      items: ['(Optional)', 'Male', 'Female'],
                      selectedValue: '(Optional)',
                      onChanged: (w) {}),
                  MyTextField(
                    hint: 'MM/DD/YYYY',
                    label: 'Birthday',
                    filledColor: kblack.withOpacity(0.05),
                    suffixIcon: Image.asset(
                      Assets.imagesCalender,
                      width: 20,
                      height: 20,
                    ),
                    delay: 1200,
                    bordercolor: ktransparent,
                  ),
                  MyTextField(
                    hint:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                    label: 'Store Bio',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 1400,
                    maxLines: 4,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            // MyButton(
            //   buttonText: 'Save info',
            //   mBottom: 40,
            //   mhoriz: 22,
            //   onTap: () {
            //     Get.to(() =>  GradientSuccessScreen
            //     (

            //       title: 'Well done',
            //      desc: 'Now let’s select your theme.',
            //      buttontext: 'Choose your theme',
            //      ontap: (){
            //       Get.to(()=>SelectTheme());
            //      },
            //     ));
            //   },
            //   )
          ],
        ));
  }
}
