import 'package:flutter/material.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/earned_commission/commission_earned.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/fullfillment/active_shopping_methods.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/order_management.dart/order_management.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/product_manage_main.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/promotions/promotions_main.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/seller_restrictions.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class SellOnRivala extends StatefulWidget {
  const SellOnRivala({super.key});

  @override
  State<SellOnRivala> createState() => _SellOnRivalaState();
}

class _SellOnRivalaState extends State<SellOnRivala> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mainMenuItems = [
      {
        'text': 'Product Management',
        'icon': Assets.imagesProductmanagement,
        'delay': 100,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: ProductManageMain()),
            )
        //  Get.to(
        //       () => ProductManageMain(),
        //       transition: Transition.downToUp,
        //       duration: const Duration(milliseconds: 1000),
        //       curve: Curves.easeInOut,
        //     ),
      },
      {
        'text': 'Promotions',
        'icon': Assets.imagesPromotion,
        'delay': 250,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: PromotionsMain()),
            )
      },
      {
        'text': 'Order Management',
        'icon': Assets.imagesOrdermanag,
        'delay': 400,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: OrderManagement()),
            )
      },
      {
        'text': 'Fulfillment',
        'icon': Assets.imagesFullfillment,
        'delay': 550,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(page: ActiveShoppingMethods()),
            )
      },
      {
        'text': 'Revenue Generated',
        'icon': Assets.imagesRevenue,
        'delay': 700,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(
                  page: CommissionEarned(
                title: 'Revenue Generated',
              )),
            )
      },
      {
        'text': 'Commissions Paid',
        'icon': Assets.imagesCommission,
        'delay': 850,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(
                page: CommissionEarned(
                  hascart: true,
                  title: 'Commissions Paid',
                ),
              ),
            )
      },
      {
        'text': 'Seller Restrictions',
        'icon': Assets.imagesSellerrestriction,
        'delay': 1000,
        'onTap': () => Navigator.of(context).push(
              CustomPageRoute(
                page: SellerRestrictionsScreen(),
              ),
            )
      },
    ];
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context, actions: [
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
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
