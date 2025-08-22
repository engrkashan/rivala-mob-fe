import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/promo_banner.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_calender.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/product_desc_widgets.dart';

class AddPdp extends StatelessWidget {
  final String? title, buttonText;
  final VoidCallback? onbuttonTap;
  final bool? hasCalender;
  const AddPdp({super.key, this.title, this.buttonText, this.onbuttonTap, this.hasCalender=true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
          height: 700,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: kwhite),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                SizedBox(
                  height: 15,
                ),
                ContainerAppbar(
                  title: title ?? 'Content Editor',
                  icon: Assets.imagesClose2,
                  textColor: kblack,
                 
                ),
    
                MyText(
                  text: 'Upload your media',
                  size: 15,
                  color: kblack,
                  weight: FontWeight.w500,
                  paddingTop: 30,
                  paddingBottom: 15,
                ),
                Bounce_widget(
                  ontap: () {},
                  widget: CustomeContainer(
                    radius: 15,
                    color: kgrey4,
                    vpad: 25,
                    widget: Center(
                        child: Image.asset(
                      Assets.imagesUpload,
                      width: 70,
                      height: 70,
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hint: 'Type header here',
                  label: 'Header 1',
                  delay: 0,
                ),
                MyTextField(
                  hint: 'Type header here',
                  label: 'Header 2',
                  delay: 0,
                ),
                MyText(
                  text: 'Body',
                  size: 15,
                  color: kblack,
                  weight: FontWeight.w500,
                  paddingBottom: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          body_items_container(),
                          SizedBox(width: 3),
                          body_items_container(icon: Assets.imagesItalic),
                          SizedBox(width: 3),
                          body_items_container(icon: Assets.imagesUnderline),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          body_items_container(icon: Assets.imagesArigth),
                          SizedBox(width: 3),
                          body_items_container(icon: Assets.imagesAcenter),
                          SizedBox(width: 3),
                          body_items_container(icon: Assets.imagesAleft),
                        ],
                      ),
                      SizedBox(width: 10),
                      ProductQuantity(
                        vpad: 1,
                        hpad: 1,
                        dpadh: 8,
                        dpadv: 3,
                        midDistance: 3,
                      ),
                      SizedBox(width: 10),
                      buttonContainer(
                        radius: 6,
                        vPadding: 3,
                        hPadding: 3,
                        text: '#EFA1FF',
                        icon: Icons.square,
                        iconColor: Color(0xffEFA1FF),
                        bgColor: kwhite,
                        borderColor: kblack,
                        txtColor: kblack,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                MyTextField(
                  delay: 0,
                  hint:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                  maxLines: 5,
                  suffixIcon: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(
                              text: '20/100',
                              color: ktertiary,
                              paddingRight: 3,
                            ),
                            Image.asset(
                              Assets.imagesCheckbox,
                              width: 15,
                              height: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              
                SizedBox(
                  height: 15,
                ),
                MyButton(
                  buttonText: buttonText ?? 'Save ad',
                  onTap: onbuttonTap ??
                      () {
                            Get.back();
                      },
                ),
                SizedBox(
                  height: 70,
                )
              ]))),
    );
  }
}


