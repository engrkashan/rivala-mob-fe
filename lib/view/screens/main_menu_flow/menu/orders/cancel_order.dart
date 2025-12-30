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

class CancelOrder extends StatefulWidget {
  final OrderModel order;
  const CancelOrder({super.key, required this.order});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  String selectedReason = 'Bought by mistake';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Cancel an Order', centerTitle: true),
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
                    title: widget.order.orderItems!.first.product!.title,
                    singlePrice: true,
                    price: widget.order.orderItems!.first.price.toString(),
                    url: widget.order.orderItems!.first.product!.image!.first,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropDown(
                      label: 'Why Are You Cancelling This Item?',
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
                ],
              ),
            ),
            Consumer<OrderProvider>(builder: (context, ref, _) {
              return MyButton(
                buttonText: 'Confirm Cancel',
                mhoriz: 22,
                mBottom: 70,
                onTap: () async {
                  await ref.updateOrderStatus(
                    widget.order.id!,
                    'cancel',
                  );
                  if (ref.error.isNotEmpty) {
                    Get.snackbar(
                      'Error',
                      ref.error,
                      backgroundColor: kred,
                      colorText: kwhite,
                    );
                    return;
                  }
                  Get.to(() => SubscriptionChange(
                        title: 'Cancelation Confirmed!',
                        appTitle: 'Cancel an Order',
                        desc:
                            'A confirmation email with your order details was sent to',
                      ));
                },
              );
            })
          ],
        ));
  }
}
