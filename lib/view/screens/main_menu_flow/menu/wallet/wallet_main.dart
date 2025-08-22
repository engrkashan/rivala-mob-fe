import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/bank_info/bank_management.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/payment/payment_management.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/tax_documentation/tax_documentation.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class WalletMain extends StatefulWidget {
  const WalletMain({super.key});

  @override
  State<WalletMain> createState() => _WalletMainState();
}

class _WalletMainState extends State<WalletMain> {


 

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
     List<Map<String, dynamic>> mainMenuItems = [
  {
    'text': 'Tax Documents',
    'icon': Assets.imagesTax,
    'delay': 100,
    'onTap': () =>
     Navigator.of(context).push(CustomPageRoute(page:TaxDocumentation()),)

  },
  {
    'text': 'Bank Info',
    'icon': Assets.imagesBankinfo,
    'delay': 250,
    'onTap': () =>
       Navigator.of(context).push(CustomPageRoute(page:BankManagement()),)
   
  },
  {
    'text': 'Payments',
    'icon': Assets.imagesPaymnet,
    'delay': 400,
    'onTap': () => 
       Navigator.of(context).push(CustomPageRoute(page:PaymentManagement()),)

  },
  
];

    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,actions: [
          circular_icon_container(),
          SizedBox(
            width: 12,
          )
        ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                    text: 'Sell On Rivala',
                    size: 28,
                    weight: FontWeight.bold,
                    color: kblack,
                    paddingLeft: 22,
                    paddingBottom: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainMenuItems.length,
                    itemBuilder: (context, index) {
                      final item = mainMenuItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ShoppingRow(
                          textt: item['text'],
                          icon: item['icon'],
                          delay: item['delay'],
                          isSelected: selectedIndex == index,
                          ontap: () {
                            setState(() {
                              selectedIndex = index;
                            });

                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              item['onTap']();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
