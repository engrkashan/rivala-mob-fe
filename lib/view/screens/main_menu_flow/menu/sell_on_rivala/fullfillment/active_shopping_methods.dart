import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/pages_aboutUs.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/fullfillment/manage_shippment_method.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/fullfillment/manual_fulfillment.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';

import '../../../../../../controllers/providers/fulfillment.dart';
import '../../../../../widgets/my_text_widget.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<fulfillmentPro>().fetchProviders();
    });
  }

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Active fulfillment providers',
            centerTitle: true,
            size: 16),
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
                    onTap: () {
                      Get.to(
                        () => ManualFulfillment(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Assets.imagesAdd3,
                    title: 'Create new provider',
                    iconSize: 22,
                    texSize: 12,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<fulfillmentPro>(
                    builder: (context, ref, _) {
                      final item = ref.allProviders;
                      if (ref.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (item == null) {
                        return Center(
                            child: MyText(
                                text: "No active fulfillment providers"));
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          physics: const BouncingScrollPhysics(),
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ShoppingRow(
                                textt: item[index].name,
                                icon: Assets.imagesShipstation,
                                // delay: item['delay'],
                                mleft: 0,
                                isSelected: selectedIndex == index,
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ManageShippmentMethod()));
                                },
                                // ontap: () {
                                //   Future.delayed(const Duration(milliseconds: 300),
                                //           () {
                                //         item['onTap']();
                                //       });
                                // },
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
