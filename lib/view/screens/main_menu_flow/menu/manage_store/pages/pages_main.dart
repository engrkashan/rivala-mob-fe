import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/create_new_page.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/pages_aboutUs.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/about_us.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PagesMain extends StatefulWidget {
  const PagesMain({super.key});

  @override
  State<PagesMain> createState() => _PagesMainState();
}

class _PagesMainState extends State<PagesMain> {
 
  @override
  Widget build(BuildContext context) {
     List<Map<String, dynamic>> mainMenuItems = [
    {
      'text': 'About Us',
      'delay': 100,
      'onTap': () => 
        Navigator.of(context).push(CustomPageRoute(page:PagesAboutus()),)
      // Get.to(
      //       () => PagesAboutus(),
      //       transition: Transition.downToUp,
      //       duration: const Duration(milliseconds: 1000),
      //       curve: Curves.easeInOut,
      //     ),
    },
    {
      'text': 'How We’re Different',
      'delay': 250,
      'onTap': () =>  Navigator.of(context).push(CustomPageRoute(page:PagesAboutus()),)
    },
    {
      'text': 'Our Founder’s Story',
      'delay': 400,
      'onTap': () =>  Navigator.of(context).push(CustomPageRoute(page:PagesAboutus()),)
    },
    {
      'text': 'Your Products',
      'delay': 550,
      'onTap': () =>  Navigator.of(context).push(CustomPageRoute(page:PagesAboutus()),)
    },
    {
      'text': 'Your Posts',
      'delay': 700,
      'onTap': () =>  Navigator.of(context).push(CustomPageRoute(page:PagesAboutus()),)
    },
    {
      'text': 'Your Followers',
      'delay': 850,
      'onTap': () =>  Navigator.of(context).push(CustomPageRoute(page:PagesAboutus()),)
    },
  ];
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Pages', centerTitle: true),
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
                     
                      Get.bottomSheet(CreateNewPage(),
                          isScrollControlled: true);
                    },
                    icon: Assets.imagesAdd3,
                    title: ' Create new page',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyText(
                    text: 'Custom Pages',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                    paddingBottom: 15,
                  ),
                  // First 3 items
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3, // First 3 items
                    itemBuilder: (context, index) {
                      final item = mainMenuItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ShoppingRow(
                          textt: item['text'],
                          icon: Assets.imagesPages,
                          delay: item['delay'],
                          textSize: 15,
                          weight: FontWeight.w500,
                          mleft: 0,
                          isSelected: false,
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

                  MyText(
                    text: 'Auto Generated Pages',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                    paddingBottom: 15,
                  ),
                  // Last 3 items
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3, // Last 3 items
                    itemBuilder: (context, index) {
                      final item =
                          mainMenuItems[mainMenuItems.length - 3 + index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ShoppingRow(
                          textt: item['text'],
                          icon: Assets.imagesPages,
                          delay: item['delay'],
                          textSize: 15,
                          weight: FontWeight.w500,
                          mleft: 0,
                          isSelected: false,
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
