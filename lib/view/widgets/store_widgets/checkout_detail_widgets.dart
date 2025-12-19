import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/choose_existing_cards.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/order_confirmation.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class order_summary_container extends StatelessWidget {
  final bool? placeOrder;
  const order_summary_container({
    super.key,
    this.placeOrder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: kgrey2)),
        color: kgrey2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // bag_items_row(showAmount: true, size: 80),
          if (placeOrder == false) ...{
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    radius: 8,
                    contentvPad: 3,
                    useCustomFont: true,
                    hint: 'Discount code or gift card',
                    filledColor: ktransparent,
                    marginBottom: 0,
                  ),
                ),
                const SizedBox(width: 8),
                buttonContainer(
                  text: 'APPLY',
                  useCustomFont: true,
                  radius: 8,
                  vPadding: 3,
                  txtColor: kdargrey,
                  bgColor: kblack.withOpacity(0.05),
                )
              ],
            ),
          },
          const SizedBox(height: 30),
          ExpandedRow(
            text1: 'Subtotal (1)',
            text2: '\$199.99',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          ExpandedRow(
            text1: 'Estimated Tax',
            text2: '\$14.00',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          ExpandedRow(
            text1: 'Promo code',
            text2: '\$17.00',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          const SizedBox(height: 20),
          ExpandedRow(
            text1: 'Total',
            text2: '\$213.00',
            color1: kblack2,
            color2: kblack2,
            size1: 16,
            size2: 16,
            weight1: FontWeight.w600,
            weight2: FontWeight.w600,
            useCustomFont: true,
          ),
          const SizedBox(height: 30),

          if (placeOrder == true)
            Mybutton2(
              buttonText: 'Place order',
              useCustomFont: true,
              ontap: () {
                Get.to(() => OrderConfirmation());
              },
            )
        ],
      ),
    );
  }
}

/////////////////////

class shipping_opt_container extends StatelessWidget {
  final bool? isFree, singleText, isActive;
  final String? date, deliveryText, title;
  final Color? border;
  const shipping_opt_container({
    super.key,
    this.isFree,
    this.date,
    this.deliveryText,
    this.singleText = false,
    this.title,
    this.border,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      color: kwhite,
      borderColor: border ?? ktransparent,
      vpad: 8,
      hpad: 8,
      radius: 8,
      widget: Row(
        children: [
          Expanded(
              child: singleText == false
                  ? TwoTextedColumn(
                      text1: date ?? 'Monday, Sep 23',
                      text2: isFree == false
                          ? deliveryText ?? '\$6.99 delivery'
                          : 'FREE delivery',
                      mBottom: 2,
                      size2: 12,
                      size1: 13,
                      color1: kheader,
                      color2: isFree == true ? kgreen : kheader,
                      weight1: FontWeight.w500,
                      useCustomFont: true,
                    )
                  : MyText(
                      text: title ?? 'Credit Card',
                      color: kdargrey,
                      size: 14,
                      useCustomFont: true,
                    )),
          CustomCheckBox(
            isActive: isActive ?? false,
            onTap: () {},
            iscircle: true,
            selectedColor: kwhite,
            unSelectedColor: ktransparent,
            bordercolor2: kblack,
            borderColor: kblack,
            iconColor: kblack,
          )
        ],
      ),
    );
  }
}

///shipping metod list

class shipping_method_list extends StatelessWidget {
  final RxBool showShippingMethod;
  const shipping_method_list({super.key, required this.showShippingMethod});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Bounce_widget(
            ontap: () {
              showShippingMethod.value = !showShippingMethod.value;
            },
            widget: CustomeContainer(
              vpad: 8,
              hpad: 8,
              borderColor: kgrey2,
              color: kwhite,
              radius: 8,
              widget: Row(
                children: [
                  store_image_stack(
                    height: 36,
                    width: 36,
                    showIcon: false,
                    showShadow: false,
                    showContent: false,
                    iconSize: 20,
                    radius: 8,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TwoTextedColumn(
                    text1: 'Blue Floral Short',
                    text2: 'Monday, Sep. 23',
                    mBottom: 2,
                    size2: 12,
                    size1: 13,
                    weight1: FontWeight.w600,
                    useCustomFont: true,
                  )),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: kblack2,
                  )
                ],
              ),
            ),
          ),
          if (showShippingMethod.value) ...{
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, Index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: shipping_opt_container(
                      isFree: Index == 0 ? true : false,
                    ),
                  );
                },
              ),
            )
          }
        ],
      ),
    );
  }
}

///payment

class payment_method_list extends StatelessWidget {
  final String? title;
  final RxBool showPaymentMethod;
  const payment_method_list(
      {super.key, required this.showPaymentMethod, this.title});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Bounce_widget(
              ontap: () {
                showPaymentMethod.value = !showPaymentMethod.value;
              },
              widget: shipping_opt_container(
                title: title,
                border: ktertiary.withOpacity(0.6),
                singleText: true,
                isActive: showPaymentMethod.value,
              )),
          if (showPaymentMethod.value) ...{
            SizedBox(
              height: 10,
            ),

            MyText(
              text: '> Use pre-existing card',
              color: kblue,
              size: 14,
              paddingLeft: 18,
              paddingBottom: 10,
              useCustomFont: true,
              onTap: () {
                Get.to(() => ChooseExistingCards());
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: MyTextField(
                hint: 'Card number',
                radius: 8,
                contentvPad: 10,
                useCustomFont: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: MyTextField(
                hint: 'Security Code',
                radius: 8,
                contentvPad: 10,
                useCustomFont: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: MyTextField(
                hint: 'Name on Card',
                radius: 8,
                contentvPad: 10,
                useCustomFont: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: MyTextField(
                hint: 'State',
                radius: 8,
                contentvPad: 10,
                useCustomFont: true,
              ),
            ),
            MyText(
              text: '+ Save card',
              color: kdarkgrey,
              size: 14,
              paddingLeft: 18,
              paddingBottom: 10,
              useCustomFont: true,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: ListView.builder(
            //     padding: EdgeInsets.all(0),
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: 3,
            //     itemBuilder: (context, Index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(bottom: 15),
            //         child: shipping_opt_container(
            //           border: kgrey2,
            //           isFree: Index == 0 ? true : false,
            //         ),
            //       );
            //     },
            //   ),
            // )
          }
        ],
      ),
    );
  }
}
