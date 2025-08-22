import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/my_order_widgets.dart';
import 'package:rivala/view/widgets/main_menu_widgets/subscription_manage_widget.dart';

class FulfillOrder extends StatefulWidget {
  const FulfillOrder({super.key});

  @override
  State<FulfillOrder> createState() => _FulfillOrderState();
}

class _FulfillOrderState extends State<FulfillOrder> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
          title: 'Fulfill an Order',
          centerTitle: true,
          haveBackButton: false
        ),
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
                  my_order_container(
                    isfilled: true,
                  ),
                  SizedBox(height: 20,),
                  subscription_management_container()
                ],
              ),
            ),
          ],
        ));
  }
}