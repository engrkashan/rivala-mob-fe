import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/navigation/add_new_section.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/pages_aboutUs.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/promo_banner.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_attribute.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_pdp.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/main_profile.dart';
import 'package:rivala/view/widgets/appbar.dart';

class AddPageSection extends StatefulWidget {
  const AddPageSection({super.key});

  @override
  State<AddPageSection> createState() => _AddPageSectionState();
}
final List<Map<String, dynamic>> sectionItems = [
  {
    "title": "Recent Products",
    "desc": "Rivale will automatically feature all of your recently added products to this section",
    "img": Assets.imagesCustomproduct2,
    "ontap": () {
        Get.back();
    },
  },
  {
    "title": "Recent Likes",
    "desc": "Rivale will automatically feature all of your recently liked posts to this section",
    "img": Assets.imagesCustomlike,
    "ontap": () {
         Get.back();
    },
  },
  {
    "title": "Recent Shares",
    "desc": "Rivale will automatically feature all of your recently shared posts to this section",
    "img": Assets.imagesCustomsharw,
    "ontap": () {
           Get.back();
    },
  },
  {
    "title": "Promo Banner",
    "desc": "Highlight special offers, announcements, or promotions to visitors",
    "img": Assets.imagesCustompromo,
    "ontap": () {
          Get.back();
   Get.bottomSheet(PromoBanner(),isScrollControlled: true);
    },
  },
  {
    "title": "Promo Pop Up",
    "desc": "A temporary window displaying promotions or messages over website content",
    "img": Assets.imagesCustompromo,
    "ontap": () {
          Get.back();
       Get.bottomSheet(PromoBanner(
        title: 'Pop Up Ad Editor',
        buttonText: 'Save banner',
       ),isScrollControlled: true);
    },
  },
  {
    "title": "Collections",
    "desc": "Showcase your favorite collections of products and services",
    "img": Assets.imagesCustomcollection2,
    "ontap": () {
            Get.back();
                    Get.bottomSheet(SearchCriteriaProducts(
                      title: 'Search Collections',
                      hintText: 'Search collections',
                      isMainMenu: true,
                    ),isScrollControlled: true);
    },
  },
  {
    "title": "Squad",
    "desc": "Add your squad's favorite products to your storefront",
    "img": Assets.imagesCustomsquad2,
    "ontap": () {
                Get.back();
                    Get.bottomSheet(SearchCriteriaProducts(
                      title: 'Search Squads',
                      hintText: 'Search Squads',
                      isMainMenu: true,
                      isSquad: true,
                    ),isScrollControlled: true);
    },
  },
  {
    "title": "Media",
    "desc": "Add photos, videos, GIFs, and the like to your storefront",
    "img": Assets.imagesCustommedia,
    "ontap": () {
      Get.bottomSheet(AddPdp(),isScrollControlled: true);
    },
  },
];
class _AddPageSectionState extends State<AddPageSection> {


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: kwhite),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ContainerAppbar(
                title: 'Add new section',
                icon: Assets.imagesClose2,
                textColor: kblack,
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sectionItems.length,
                itemBuilder: (context, index) {
                  final item = sectionItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: add_section_row(
                      title: item["title"],
                      desc: item["desc"],
                    
                      img: item["img"],
                      ontap: item["ontap"],
                      delay: (index+1)*150,
                    ),
                  );
                },
              ),
          
              // MyButton(
              //   buttonText: 'Add section',
              //   mBottom: 0,
              //   onTap: (){
              //         Get.back();
              //   },
              // )
            ],
          ),
        ));
  }
}

