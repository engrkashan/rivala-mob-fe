import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/pages_aboutUs.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/fullfillment/manage_shippment_method.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/fullfillment/manual_fulfillment.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';

class ActiveShoppingMethods extends StatefulWidget {
  const ActiveShoppingMethods({super.key});

  @override
  State<ActiveShoppingMethods> createState() => _ActiveShoppingMethodsState();
}

class _ActiveShoppingMethodsState extends State<ActiveShoppingMethods> {
  List<Map<String, dynamic>> mainMenuItems = [
    {
      'text': 'ShipStation',
      'icon': Assets.imagesShipstation,
      'delay': 100,
      'onTap': () => Get.to(
            () => ManageShippmentMethod(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          ),
    },
    {
      'text': 'FBA Amazon',
      'icon': Assets.imagesAmazon,
      'delay': 250,
      'onTap': () => Get.to(
            () => PagesAboutus(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          ),
    },
    {
      'text': 'Manual',
      'icon': Assets.imagesManual,
      'delay': 400,
      'onTap': () => Get.to(
            () => ManualFulfillment(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
          ),
    },
  ];
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
            title: 'Active fulfillment providers', centerTitle: true, size: 16),
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
                  row_widget(
                    onTap: () {},
                    icon: Assets.imagesAdd3,
                    title: 'Create new provider',
                    iconSize: 22,
                    texSize: 12,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20,
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
                          mleft: 0,
                          isSelected: selectedIndex == index,
                          ontap: () {
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
