import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/main.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/choose_theme.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/create_links.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/link_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class MasterAccountSet extends StatefulWidget {
  const MasterAccountSet({super.key});

  @override
  State<MasterAccountSet> createState() => _MasterAccountSetState();
}

class _MasterAccountSetState extends State<MasterAccountSet> {
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
                    hint: 'MM/DD/YYYY',
                    label: 'Birthday',
                    filledColor: kblack.withOpacity(0.05),
                    suffixIcon: Image.asset(
                      Assets.imagesCalender,
                      width: 20,
                      height: 20,
                    ),
                    delay: 800,
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
                    delay: 1000,
                    maxLines: 4,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            MyButton(
              buttonText: 'Save info',
              mBottom: 40,
              mhoriz: 22,
              onTap: () {
                Get.to(() =>  GradientSuccessScreen
                (

                  title: 'Well done',
                 desc: 'Now let’s select your theme.',
                 buttontext: 'Choose your theme',
                 ontap: (){
                  Get.to(()=>SelectTheme());
                 },
                 skipTap: (){
                  Get.back();
                   Get.to(()=>GradientSuccessScreen(
                            title: 'Well done!',
                            desc: 'Now, let’s import your links.',
                            buttontext: 'Import your links',
                            ontap: () {
                              Get.to(() => MasterCreateLink());
                            },
                                     skipTap: (){
                  
                   Get.to(()=>MAsterLinkSuccess());
                 },
                          ));
                 },
                ));
              },
            )
          ],
        ));
  }
}

class EditImgStack extends StatelessWidget {
  const EditImgStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommonImageView(
            url: dummyImage,
            width: 109,
            height: 109,
            radius: 100,
          ),
          Positioned(
               bottom: -15,
              left: -6,
              child: Bounce_widget(
                  widget: Image.asset(
                Assets.imagesReplace,
                width: 54,
                height: 54,
              )))
        ],
      ),
    );
  }
}
