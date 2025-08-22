import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/checkout_detail_widgets.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';

class CheckoutDetail extends StatefulWidget {
  const CheckoutDetail({super.key});

  @override
  State<CheckoutDetail> createState() => _CheckoutDetailState();
}

class _CheckoutDetailState extends State<CheckoutDetail> {
  bool isOrderSummaryVisible = true;
  bool showShippingMethod = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          body: ImageLayoutWidget(
            bodyWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ContainerAppbar(title: 'Checkout',),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: kgrey2),
                ),
                Center(
                  child: row_widget(
                    icon: Assets.imagesNutritionrescue,
                    title: 'Nutrition Rescue',
                    weight: FontWeight.w600,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: kgrey2),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOrderSummaryVisible = !isOrderSummaryVisible;
                          });
                        },
                        child: row_widget(
                           useCustomFont: true,
                          title: isOrderSummaryVisible
                              ? 'Hide order summary'
                              : 'Show order summary',
                          textColor: kheader,
                          iconData: isOrderSummaryVisible
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          isIconRight: true,
                        ),
                      ),
                      MyText(
                        text: '\$50.00',
                        size: 16,
                        color: kblack,
                        weight: FontWeight.w700,
                         useCustomFont: true,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                //ORDER SUMMARY
                if (isOrderSummaryVisible) order_summary_container(),

                //SHIPPING MENTHODS

                MyText(
                  text: 'Shipping Method',
                  size: 18,
                  color: kblack,
                  paddingTop: 30,
                  paddingLeft: 18,
                  weight: FontWeight.w500,
                  paddingBottom: 20,
                   useCustomFont: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kgrey2,
                      ),
                      child: Column(
                        children: [
                          //MyText(text: ''),
                          ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: shipping_method_list(
                                  showShippingMethod:
                                      index == 0 ? true.obs : false.obs,
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                shipping_address_bool(),
                Center(
                  child: MyText(
                    text: 'Express Checkout',
                    size: 18,
                    color: kbody,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    paddingTop: 20,
                    paddingBottom: 10,
                     useCustomFont: true,
                  ),
                ),
                checkout_opts(),
                SizedBox(
                  height: 10,
                ),
                checkout_opts(
                    icon: Assets.imagesPaypal, color: Color(0xffFFD140)),
                SizedBox(
                  height: 10,
                ),
                checkout_opts(
                  icon: Assets.imagesGpay,
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    label: 'Contact',
                    hint: 'janesmith@gmail.com',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    label: 'Shipping Address',
                    hint: 'United States',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'First Name',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'Last Name',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'Address',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'Apartment, suite, etc (optional)',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'City',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'Zip Code',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyTextField(
                    hint: 'Phone',
                    radius: 8,
                    contentvPad: 10,
                     useCustomFont: true,
                  ),
                ),
                MyText(
                  text: 'Payment',
                  size: 15,
                  weight: FontWeight.w500,
                  color: kblack,
                  paddingBottom: 8,
                  paddingTop: 15,
                  paddingLeft: 18,
                   useCustomFont: true,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kgrey2,
                      ),
                      child: Column(
                        children: [
                          //MyText(text: ''),
                          ListView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: payment_method_list(
                                  title: index == 1 ? 'Paypal' : 'Credit Card',
                                  showPaymentMethod:
                                      index == 0 ? true.obs : false.obs,
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                shipping_address_bool(),
                SizedBox(
                  height: 20,
                ),
                order_summary_container(
                  placeOrder: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class shipping_address_bool extends StatelessWidget {
  const shipping_address_bool({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckBox(
            isActive: true,
            onTap: () {},
            radius: 5,
          ),
          Expanded(
              child: MyText(
            text: 'Use shipping address as billing address',
            size: 13,
            color: kbody,
            paddingLeft: 5,
             useCustomFont: true,
          ))
        ],
      ),
    );
  }
}

class checkout_opts extends StatelessWidget {
  final String? icon;
  final VoidCallback? ontap;
  final Color? color;
  const checkout_opts({
    super.key,
    this.icon,
    this.ontap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Bounce_widget(
        ontap: ontap,
        widget: CustomeContainer(
          radius: 8,
          vpad: 9,
          color: color ?? kblack,
          widget: Center(
              child: Image.asset(
            icon ?? Assets.imagesApplepay,
            width: 58,
            height: 23,
          )),
        ),
      ),
    );
  }
}
