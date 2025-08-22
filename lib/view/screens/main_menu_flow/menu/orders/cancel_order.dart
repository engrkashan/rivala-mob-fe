import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/subscription/subscription_change.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({super.key});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Cancel an Order',centerTitle: true),
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
                      selectedValue: 'Bought by mistake',
                      onChanged: (e) {}),
                          SizedBox(
                    height: 10,
                  ),
                     
                ],
              ),
            ),
            MyButton(
              buttonText: 'Confirm Cancel',
              mhoriz: 22,
              mBottom: 70,
              onTap: (){
          Get.to(()=>SubscriptionChange(
            title:'Cancelation Confirmed!' ,
            appTitle: 'Cancel an Order',
            
          ));
              },
            )
          ],
        ));
  }
}
