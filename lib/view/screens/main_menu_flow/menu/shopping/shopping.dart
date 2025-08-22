import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/guest_accout_login/login_guest_account.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/subscription/subscription_management.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
 
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
     List<Map<String, dynamic>> mainMenuItems = [
    {
      'textt': 'Orders',
      'icon': Assets.imagesOrders,
      'delay': 100,
      'ontap': () => 
       Navigator.of(context).push(CustomPageRoute(page:LoginGuestAccount()),)
      // Get.to(
      //       () => LoginGuestAccount(),
      //       transition: Transition.downToUp,
      //       duration: const Duration(milliseconds: 1000),
      //       curve: Curves.easeInOut,
      //     ),
    },
    {
      'textt': 'Subscriptions',
      'icon': Assets.imagesSubscription,
      'delay': 250,
      'ontap': () =>
             Navigator.of(context).push(CustomPageRoute(page:SubscriptionManagement()),)
      //  Get.to(
      //       () => SubscriptionManagement(),
      //       transition: Transition.downToUp,
      //       duration: const Duration(milliseconds: 1500),
      //       curve: Curves.easeInOut,
      //     ),
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
                    text: 'Shopping',
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
                          textt: item['textt'],
                          icon: item['icon'],
                          delay: item['delay'],
                          isSelected: selectedIndex == index,
                          ontap: () {
                            setState(() {
                              selectedIndex = index;
                            });

                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              item['ontap']();
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

class ShoppingRow extends StatelessWidget {
  final String? icon, textt;
  final VoidCallback? ontap;
  final int? delay;
  final bool isSelected;
  final bool? justIcon;
  final FontWeight? weight;
final double? textSize,mleft,mrigth;
  const ShoppingRow({
    super.key,
    this.icon,
    this.textt,
    this.ontap,
    this.delay,
    required this.isSelected, this.textSize, this.mleft, this.weight, this.justIcon=false, this.mrigth,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: Animate(
        effects: [MoveEffect(delay: Duration(milliseconds: delay ?? 100))],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            gradient: isSelected ? kgradmainmenu : null,
          ),
          margin: EdgeInsets.only(left:mleft?? 30, right: isSelected ? 0 :mrigth?? 20),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Row(
            children: [
              if(justIcon==true)
              Image.asset(icon??Assets.imagesBankinfo,width:26 ,height: 26,),
              if(justIcon==false)
              circular_icon_container(
                size: 50,
                iconSize: 22,
                icon: icon,
                iconColor: isSelected ? kwhite : kblue2,
                bgColor: isSelected
                    ? kwhite.withOpacity(0.09)
                    : kmenuGreen.withOpacity(0.1),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: MyText(
                text: textt ?? 'Orders',
                size:textSize?? 18,
                color: isSelected ? kwhite : kdargrey,
                weight:weight?? FontWeight.bold,
              )),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: isSelected ? kwhite : kdarkgrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
