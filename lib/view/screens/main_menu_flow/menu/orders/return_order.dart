import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/subscription/subscription_change.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../../../models/order_model.dart';

class ReturnOrder extends StatefulWidget {
  final OrderModel order;
  const ReturnOrder({super.key, required this.order});

  @override
  State<ReturnOrder> createState() => _ReturnOrderState();
}

class _ReturnOrderState extends State<ReturnOrder> {
  String selectedReason = 'Bought by mistake';
  String selectedRefundMethod = 'Refund to your Rivala account balance';
  String selectedMailMethod = 'UPS Drop-off ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Return an Order', centerTitle: true),
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
                  store_image_stack(
                    width: 142,
                    height: 142,
                    showIcon: false,
                    contentColor: kblack,
                    singlePrice: true,
                    url: widget.order.orderItems!.first.product!.image!.first,
                    price: widget.order.orderItems!.first.product!.price
                        .toString(),
                    title: widget.order.orderItems!.first.product!.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropDown(
                      label: 'Why Are You Returning This Item?',
                      hint: 'Bought by mistake',
                      items: [
                        'Bought by mistake',
                        'Better price available',
                        'Product damaged',
                        'Arrived too late',
                        'Wrong item was sent',
                        'No longer needed',
                        "Didn't approve purchase",
                      ],
                      selectedValue: selectedReason,
                      onChanged: (e) {
                        selectedReason = e;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropDown(
                      label: 'How Would You Like Your Refund?',
                      hint: 'Refund to your Rivala account balance',
                      items: [
                        'Refund to your Rivala account balance',
                        'Refund to your original payment method',
                      ],
                      selectedValue: selectedRefundMethod,
                      onChanged: (e) {
                        selectedRefundMethod = e;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropDown(
                      label: 'How Will You Mail Your Return?',
                      hint: 'Refund to your Rivala account balance',
                      items: [
                        'UPS Drop-off ',
                        'USPS Drop-off ',
                      ],
                      selectedValue: selectedMailMethod,
                      onChanged: (e) {
                        selectedMailMethod = e;
                        setState(() {});
                      })
                ],
              ),
            ),
            Consumer<OrderProvider>(builder: (context, ref, _) {
              return MyButton(
                buttonText: 'Confirm Return',
                mhoriz: 22,
                mBottom: 70,
                onTap: () async {
                  await ref.updateOrderStatus(
                    widget.order.id!,
                    'return',
                  );
                  if (ref.error.isNotEmpty) {
                    Get.snackbar(
                      'Error',
                      ref.error,
                    );
                    return;
                  }
                  Get.to(() => SubscriptionChange(
                        title: 'Return Confirmed!',
                        appTitle: 'Return an Order',
                        desc: "",
                        email: "",
                      ));
                },
              );
            })
          ],
        ));
  }
}
