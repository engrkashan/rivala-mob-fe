import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PromoCode extends StatelessWidget {
  final String? title;
  final bool? isPromo, isMinMax;

  const PromoCode(
      {super.key, this.title, this.isPromo = false, this.isMinMax = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: kwhite),
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bounce_widget(
                  ontap: () {
                        Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesBackicon1,
                    width: 22,
                    height: 22,
                  )),
              MyText(
                text: title ?? 'Promo Code',
                size: 15,
                weight: FontWeight.w500,
              ),
              Bounce_widget(
                  ontap: () {
                        Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose2,
                    width: 22,
                    height: 22,
                  ))
            ],
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            hint: 'Search Products',
            prefixIcon: Image.asset(
              Assets.imagesSearch,
              width: 15,
              height: 15,
            ),
            readOnly: true,
            ontapp: () {
                  Get.back();
              Get.bottomSheet(SearchCriteriaProducts(),
                  isScrollControlled: true);
            },
            contentvPad: 6,
          ),
          ////if minmax

          if (isMinMax == true) ...{
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyText(
                    text: 'Minimum Purchase',
                    size: 12,
                    paddingRight: 8,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: MyTextField(
                    radius: 50,
                    marginBottom: 0,
                    hint: '\$100',
                    contentvPad: 4,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyText(
                    text: 'Maximum Purchase',
                    size: 12,
                    paddingRight: 8,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: MyTextField(
                    radius: 50,
                    marginBottom: 0,
                    hint: '\$100',
                    contentvPad: 4,
                  ),
                ),
              ],
            ),
          },

          ////if promo
          if (isPromo == true) ...{
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                MyText(
                  text: 'Set Code',
                  size: 12,
                  paddingRight: 8,
                ),
                Expanded(
                  child: MyTextField(
                    radius: 50,
                    marginBottom: 0,
                    hint: 'Enter Promo Code',
                    contentvPad: 4,
                  ),
                ),
              ],
            ),
          },

          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyText(
                  text: 'Discount Type',
                  size: 12,
                  paddingRight: 8,
                  paddingTop: 4,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: CustomDropDown(
                      vpad: 4,
                      iconPad: 2,
                      bgColor: ktransparent,
                      bordercolor: ktertiary,
                      hint: 'Choose your discount type',
                      items: ['Discount shipping', 'Discount entire order'],
                      selectedValue: 'Discount entire order',
                      onChanged: (e) {})),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyText(
                  text: 'Discount Amount',
                  size: 11,
                  paddingRight: 8,
                ),
              ),
              Expanded(
                flex: 3,
                child: MyTextField(
                  radius: 50,
                  marginBottom: 0,
                  hint: '10%',
                  contentvPad: 4,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: CustomeContainer(
                  vpad: 2,
                  hpad: 3,
                  color: kblack.withOpacity(0.05),
                  widget: Row(
                    children: [
                      Bounce_widget(
                        widget: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.minimize_rounded,
                            color: kblack,
                            size: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomeContainer(
                          color: kwhite,
                          vpad: 4,
                          hpad: 2,
                          radius: 4,
                          widget: MyText(
                            text: '70%',
                            size: 8,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Bounce_widget(
                          widget: Icon(
                        Icons.add_rounded,
                        color: kblack,
                        size: 14,
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          MyButton(
            buttonText: 'Save criteria',
            onTap: () {
                  Get.back();
            },
            mBottom: 60,
          )
        ]));
  }
}
