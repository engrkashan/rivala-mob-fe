import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/cancel_order.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/replace_order.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/return_order.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/order_management.dart/fulfill_order.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../models/order_model.dart';
import '../../screens/main_menu_flow/menu/shopping/subscription/subscription_change.dart';
import '../../screens/master_store_flow/store_home/product_detailed_description.dart';

class my_order_container extends StatefulWidget {
  final String? date, amount, savedAmount;
  final int? delay;
  final bool? hasfulfuill, isfilled;
  final OrderModel? order;
  const my_order_container({
    super.key,
    this.date,
    this.amount,
    this.savedAmount,
    this.delay,
    this.hasfulfuill = false,
    this.isfilled = false,
    this.order,
  });

  @override
  State<my_order_container> createState() => _my_order_containerState();
}

class _my_order_containerState extends State<my_order_container> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Animate(
      effects: [MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100))],
      child: CustomeContainer(
        color: kwhite,
        hpad: 10,
        hasShadow: true,
        radius: 15,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MyText(
                    text:
                        "${order?.createdAt?.month}, ${order?.createdAt?.day}, ${order?.createdAt?.year}",
                    size: 13,
                    weight: FontWeight.w400,
                  ),
                ),
                Bounce_widget(
                    ontap: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    widget: Icon(isActive == true
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right_rounded))
              ],
            ),
            row_widget(
              icon: Assets.imagesTruck,
              iconSize: 12,
              title: order?.status,
              textColor: kgreen,
              fontstyle: FontStyle.italic,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                MyText(
                  text: 'AMOUNT: ',
                  size: 11,
                  weight: FontWeight.w500,
                ),
                MyText(
                  text: "${order?.payment?.amount}",
                  size: 11,
                  weight: FontWeight.w400,
                )
              ],
            ),
            // Row(
            //   children: [
            //     MyText(
            //       text: 'ORDER NUMBER: ',
            //       size: 11,
            //       weight: FontWeight.w500,
            //     ),
            //     MyText(
            //       text: order?.id ?? '2249821585154',
            //       size: 11,
            //       weight: FontWeight.w400,
            //     )
            //   ],
            // ),
            if (widget.hasfulfuill == true)
              // Row(
              //   children: [
              //     MyText(
              //       text: 'CUSTOMER: ',
              //       size: 11,
              //       weight: FontWeight.w500,
              //     ),
              //     CommonImageView(
              //       imagePath: Assets.imagesUser,
              //       width: 15,
              //       height: 15,
              //     ),
              //     MyText(
              //       paddingLeft: 10,
              //       text: order?.,
              //       size: 11,
              //       weight: FontWeight.w400,
              //     )
              //   ],
              // ),
              MyText(
                text: 'PRODUCT(S):',
                size: 11,
                weight: FontWeight.w500,
                paddingBottom: 10,
                paddingTop: 0,
              ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: order?.product?.image?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  print("Product names: ${order?.product?.title}");
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 10),

                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailedDescription(
                              product: order!.product!,
                            ));
                      },
                      child: CommonImageView(
                        url: order?.product?.image?[index],
                        radius: 50,
                        width: 60,
                      ),
                    ),

                    // child: subscription_sub_widget(
                    //   hasRadio: true,
                    //   ontap: () {
                    //     // Get.to(() => ProductDetailedDescription());
                    //   },
                    // ),
                  );
                },
              ),
            ),
            if (widget.isfilled == false)
              MyText(
                text: 'Manage Your Order',
                color: kblack,
                size: 11,
                paddingLeft: 30,
                paddingBottom: 8,
                paddingTop: 15,
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (widget.isfilled == true) ? 0 : 30),
              child: (widget.isfilled == true)
                  ? Row(
                      children: [
                        Bounce_widget(
                          widget: CustomeContainer(
                            radius: 8,
                            vpad: 6,
                            hpad: 5,
                            color: ktertiary,
                            widget: Consumer<OrderProvider>(
                                builder: (context, ref, _) {
                              return GestureDetector(
                                onTap: () async {
                                  await ref.updateOrderStatus(
                                    widget.order!.id!,
                                    'fulfill',
                                  );
                                  if (ref.error.isNotEmpty) {
                                    Get.snackbar(
                                      'Error',
                                      ref.error,
                                    );
                                    return;
                                  }
                                  Get.to(() => SubscriptionChange(
                                        title: 'Order Fulfilled!',
                                        appTitle: 'Fulfill an Order',
                                        desc: "",
                                        email: "",
                                      ));
                                },
                                child: MyText(
                                  text: 'Mark as Fulfilled',
                                  size: 9,
                                  color: kwhite,
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        //for each ontap here, first there will be an iphone popup and these screens

                        Bounce_widget(
                          ontap: () {
                            Get.to(() => ReturnOrder(
                                  order: widget.order!,
                                ));
                          },
                          widget: CustomeContainer(
                            radius: 8,
                            vpad: 6,
                            hpad: 5,
                            color: ktertiary,
                            widget: MyText(
                              text: 'Return',
                              size: 9,
                              color: kwhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Bounce_widget(
                          ontap: () {
                            Get.to(() => CancelOrder(
                                  order: widget.order!,
                                ));
                          },
                          widget: CustomeContainer(
                            radius: 8,
                            vpad: 6,
                            hpad: 5,
                            color: ktertiary,
                            widget: MyText(
                              text: 'Cancel',
                              size: 9,
                              color: kwhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Bounce_widget(
                          ontap: () {
                            Get.to(() => ReplaceOrder());
                          },
                          widget: CustomeContainer(
                            radius: 8,
                            vpad: 6,
                            hpad: 5,
                            color: ktertiary,
                            widget: MyText(
                              text: 'Replace',
                              size: 9,
                              color: kwhite,
                            ),
                          ),
                        ),
                        if (widget.hasfulfuill == true) ...{
                          SizedBox(
                            width: 10,
                          ),
                          Bounce_widget(
                            ontap: () {
                              Get.to(() => FulfillOrder(
                                    order: order,
                                  ));
                            },
                            widget: CustomeContainer(
                              radius: 8,
                              vpad: 6,
                              hpad: 5,
                              color: ktertiary,
                              widget: MyText(
                                text: 'Fulfill',
                                size: 9,
                                color: kwhite,
                              ),
                            ),
                          ),
                        }
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
