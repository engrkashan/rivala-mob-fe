import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/my_order_widgets.dart';
import 'package:rivala/view/widgets/main_menu_widgets/subscription_manage_widget.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class MyOrders extends StatefulWidget {
  String? orderId;
  MyOrders({super.key, this.orderId});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Your Orders', centerTitle: true),
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
                  MyTextField(
                    hint: 'Search Order History',
                    prefixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 12,
                    ),
                  ),
                  my_order_container(),
                  SizedBox(
                    height: 15,
                  ),
                  subscription_management_container(),
                  SizedBox(
                    height: Platform.isIOS ? 120 : 100,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
