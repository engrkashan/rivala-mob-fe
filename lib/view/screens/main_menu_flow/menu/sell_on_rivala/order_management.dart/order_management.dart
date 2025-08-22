import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/my_order_widgets.dart';
import 'package:rivala/view/widgets/main_menu_widgets/subscription_manage_widget.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class OrderManagement extends StatefulWidget {
  const OrderManagement({super.key});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Order Management', centerTitle: true),
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
            ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: my_order_container(
                        hasfulfuill: true,
                      ),
                    );
                  },
                ),

                  SizedBox(height: 80,)
                ],
              ),
            ),
          ],
        ));
  }
}
