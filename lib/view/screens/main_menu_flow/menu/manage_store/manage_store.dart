import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/collection/collection.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/earned_commission/commission_earned.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/navigation/navigation.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/pages_main.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/personal_info/personal_info.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/customize_theme.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class ManageStore extends StatefulWidget {
  const ManageStore({super.key});

  @override
  State<ManageStore> createState() => _ManageStoreState();
}

class _ManageStoreState extends State<ManageStore> {
 

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
     List<Map<String, dynamic>> mainMenuItems = [
    {
      'text': 'Earned Commissions',
      'icon': Assets.imagesEarned,
      'delay': 100,
      'onTap': () => 
      Navigator.of(context).push(CustomPageRoute(page:CommissionEarned()),)
      // Get.to(
      //       () => CommissionEarned(),
      //       transition: Transition.downToUp,
      //       duration: const Duration(milliseconds: 1000),
      //       curve: Curves.easeInOut,
      //     ),
    },
    {
      'text': 'Personal Info',
      'icon': Assets.imagesPersonalInfo,
      'delay': 250,
      'onTap': () => 
      Navigator.of(context).push(CustomPageRoute(page:ManagePersonalInfo()),)
  
    },
    {
      'text': 'Store Theme',
      'icon': Assets.imagesStoretheme,
      'delay': 400,
      'onTap': () =>
      Get.to(()=>SelectTheme(
              title: 'Store Theme',
              buttonText: 'Customize your theme',
              buttonTap: () {
                Get.to(() => CustomizeTheme());
              },
            ),)

   
    },
    {
      'text': 'Pages',
      'icon': Assets.imagesPages,
      'delay': 550,
      'onTap': () => 
        Navigator.of(context).push(CustomPageRoute(page:PagesMain()),)

    },
    {
      'text': 'Collections',
      'icon': Assets.imagesCollection3,
      'delay': 700,
      'onTap': () => 
        Navigator.of(context).push(CustomPageRoute(page:CollectionMain()),)
 
    },
    {
      'text': 'My Links',
      'icon': Assets.imagesLinks,
      'delay': 850,
      'onTap': () => 
        Navigator.of(context).push(CustomPageRoute(page:CreateNewLink(
              hasAddOpt: true,
              hasDelete: true,
            ),),)

    },
    {
      'text': 'Navigation',
      'icon': Assets.imagesNavigation,
      'delay': 1000,
      'onTap': () =>
       Navigator.of(context).push(CustomPageRoute(page:NavigationMain())),
    
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
                    text: 'Manage Your Store',
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
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ],
        ));
  }
}
