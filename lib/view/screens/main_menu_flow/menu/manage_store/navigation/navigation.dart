import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/navigation/create_new_menuItem.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/main_menu_widgets/commission_widgets.dart';
import 'package:rivala/view/widgets/main_menu_widgets/navigation_widgets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class NavigationMain extends StatefulWidget {
  const NavigationMain({super.key});

  @override
  State<NavigationMain> createState() => _NavigationMainState();
}

class _NavigationMainState extends State<NavigationMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Navigation', centerTitle: true),
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
                      Get.to(() => CreateNewMenuitem());
                    },
                    icon: Assets.imagesAdd3,
                    title: ' Create new menu section',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                     ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: navigation_container(),
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

class navigation_container extends StatefulWidget {
  final String? title,desc;
  const navigation_container({
    super.key, this.title, this.desc,
  
  });



  @override
  State<navigation_container> createState() => _navigation_containerState();
}

class _navigation_containerState extends State<navigation_container> {
    final List products = ['Women', 'Men', 'Kids'];
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      hasShadow: true,
      vpad: 12,
      hpad: 12,
      color: kwhite,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text:widget.title?? 'Products',
                size: 15,
                color: kblack,
              ),
              Bounce_widget(
                  ontap: () {
               setState(() {
                 isActive=!isActive;
               });
                  },
                  widget: Icon(
                  isActive
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right_rounded,
                    color: kblack,
                  ))
            ],
          ),
          MyText(
            text:widget.desc?? 'Custom page',
            size: 11,
            color: kblack,
            fontStyle: FontStyle.italic,
            weight: FontWeight.w300,
            paddingBottom: 15,
          ),
          !isActive
              ? horizontal_img_list()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: navigation_info_container(
                          title: products[index]),
                    );
                  },
                ),
                if(    !isActive)
          MyText(
            paddingTop: 10,
            text: 'Edit menu section >',
            size: 12,
            weight: FontWeight.w500,
            color: kblue,
            onTap: () {
              // Get.bottomSheet(AddNewSection(),isScrollControlled: true);
            },
          ),
        ],
      ),
    );
  }
}
