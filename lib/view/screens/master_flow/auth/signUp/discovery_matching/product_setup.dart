import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/widgets/animate_widgets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class ProductSetup extends StatefulWidget {
  const ProductSetup({super.key});

  @override
  State<ProductSetup> createState() => _ProductSetupState();
}

class _ProductSetupState extends State<ProductSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context,title: 'Product Setup', centerTitle: true, actions: [
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
                  square_image_stack(),
                  SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                    hint: 'Name',
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
                    hint: 'Physical Good',
                    label: 'Product Type',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 400,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  CustomDropDown(
                      delay: 600,
                      label: 'Status',
                      hint: 'Live',
                      items: [
                        'Off',
                        'Paused',
                        'Live',
                      ],
                      selectedValue: 'Live',
                      onChanged: (e) {}),
                  MyTextField(
                    hint: '20%',
                    label: 'Commission',
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
                      delay: 1000,
                      label: 'Available for Subscription',
                      hasSwitch: true,
                      hint: 'Weekly',
                      items: [
                        'Monthly',
                        'Quarterly',
                        'Weekly',
                      ],
                      selectedValue: 'Weekly',
                      onChanged: (e) {}),
                  MyTextField(
                    hint: 'Search promos',
                    label: 'Attach a Promo to Subscription',
                    prefixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 11,
                      height: 11,
                    ),
                    hintSize: 11,
                    delay: 1200,
                    contentvPad: 5,
                    bordercolor: ktertiary,
                  ),
                  promo_row(
                    delay: 1300,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  promo_row(
                    title: 'Black Friday',
                    delay: 1400,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SlideAnimation(
                    delay: 1500,
                    child: MyText(
                      text: '+ New promo',
                      size: 12,
                      weight: FontWeight.w500,
                      paddingBottom: 15,
                      color: kblue,
                    ),
                  ),
                  MyTextField(
                    hint:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                    label: 'Summary',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 1600,
                    maxLines: 4,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  MyTextField(
                    hint:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                    label: 'Special Notes',
                    suffixIcon: Image.asset(
                      Assets.imagesEdit,
                      width: 20,
                      height: 20,
                    ),
                    delay: 1650,
                    maxLines: 4,
                    filledColor: kblack.withOpacity(0.05),
                    bordercolor: ktransparent,
                  ),
                  SlideAnimation(
                    delay: 1700,
                    child: TwoTextedColumn(
                      text1: 'Add to Collection',
                      text2: '+ New collection',
                      size1: 15,
                      size2: 12,
                      color1: kblack,
                      color2: kblue,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      mBottom: 10,
                    ),
                  ),
                  SizedBox(height: 23,),
                  SlideAnimation(
                    delay: 1750,
                    child: TwoTextedColumn(
                      text1: 'Media',
                      text2: '+ Add media',
                      size1: 15,
                      size2: 12,
                      color1: kblack,
                      color2: kblue,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      mBottom: 10,
                    ),
                  ),
                    SizedBox(height: 23,),
                  SlideAnimation(
                    delay: 1800,
                    child: TwoTextedColumn(
                      text1: 'PDP Features & Benefits',
                      text2: '+ Add new feature',
                      size1: 15,
                      size2: 12,
                      color1: kblack,
                      color2: kblue,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      mBottom: 10,
                    ),
                  ),
                    SizedBox(height: 23,),
                  SlideAnimation(
                    delay:1850,
                    child: TwoTextedColumn(
                      text1: 'Attributes',
                      text2: '+ Add new attribute',
                      size1: 15,
                      size2: 12,
                      color1: kblack,
                      color2: kblue,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      mBottom: 10,
                    ),
                  ),
                    SizedBox(height: 23,),
                  SlideAnimation(
                    delay: 1900,
                    child: TwoTextedColumn(
                      text1: 'Attach a Promo',
                      text2: '+ New Promo',
                      size1: 15,
                      size2: 12,
                      color1: kblack,
                      color2: kblue,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      mBottom: 10,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            Mybutton2(
              buttonText: 'Save Changes',
           hpad: 22,
          mbot: 30,
              ontap: () {
                Get.to(() => GradientSuccessScreen());
              },
            )
          ],
        ));
  }
}

class square_image_stack extends StatelessWidget {
  const square_image_stack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
      Bounce_widget(
        ontap: () {},
        widget: CustomeContainer(
          height: 150,
          width: 150,
          color: kbackground,
          radius: 15,
          mtop: 0,
          widget: Center(
              child: Image.asset(
            Assets.imagesExportt,
            color: ktertiary.withOpacity(0.5),
            width: 70,
            height: 69,
          )),
        ),
      ),
          Positioned(
              bottom: -15,
              left: -6,
              child: Bounce_widget(
                  widget: Image.asset(
                Assets.imagesEdit2,
                width: 42,
                height: 42,
              )))
        ],
      ),
    );
  }
}

class promo_row extends StatelessWidget {
  final String? title,icon;
  final int? delay;
  final bool? hasButton;
  final Color? iconColor;
  const promo_row({
    super.key,
    this.title,
    this.delay, this.icon, this.hasButton=false, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      delay: delay,
      child: Row(
        children: [
          CustomeContainer(
            radius: 8,
            vpad: 9,
            hpad: 9,
            borderColor: ktertiary,
            widget: Center(
              child: Image.asset(
              icon??  Assets.imagesPercent,
                width: 22,
                height: 22,
                color: iconColor,
              ),
            ),
          ),
          Expanded(
              child:hasButton==false? MyText(
            text:title?? 'Cyber Monday',
            size: 15,
            color: kblack,
            paddingLeft: 13,
          ):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
MyText(
            text:title?? 'Cyber Monday',
            size: 15,
            color: kblack,
            paddingLeft: 13,
            paddingBottom: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              children: [
                buttonContainer(
                  radius: 10,
                  text: 'Edit',
                  bgColor: ktertiary,
                  txtColor: kwhite,
                  vPadding: 1,
                  hPadding: 8,
                  textsize: 9,
                ),
              ],
            ),
          )
            ],
          )),
          CustomCheckBox(
            isActive: true,
            onTap: () {},
            iscircle: true,
            circleIcon: Icons.check,
            size: 30,
            circleIconsize: 20,
          )
        ],
      ),
    );
  }
}
