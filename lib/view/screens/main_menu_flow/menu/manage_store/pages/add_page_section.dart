import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/controllers/providers/pages_provider.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/controllers/providers/squads_provider.dart';
import 'package:rivala/models/collection_model.dart';
import 'package:rivala/models/squad_model.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/navigation/add_new_section.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/promo_banner.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_pdp.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/appbar.dart';

class AddPageSection extends StatefulWidget {
  final String? pageId;
  final int? insertIndex;
  const AddPageSection({super.key, this.pageId, this.insertIndex});

  @override
  State<AddPageSection> createState() => _AddPageSectionState();
}

final List<Map<String, dynamic>> sectionItems = [
  {
    "title": "Recent Products",
    "desc":
        "Rivale will automatically feature all of your recently added products to this section",
    "img": Assets.imagesCustomproduct2,
    "ontap": () {
      Get.back();
    },
  },
  {
    "title": "Recent Likes",
    "desc":
        "Rivale will automatically feature all of your recently liked posts to this section",
    "img": Assets.imagesCustomlike,
    "ontap": () {
      Get.back();
    },
  },
  {
    "title": "Recent Shares",
    "desc":
        "Rivale will automatically feature all of your recently shared posts to this section",
    "img": Assets.imagesCustomsharw,
    "ontap": () {
      Get.back();
    },
  },
  {
    "title": "Promo Banner",
    "desc":
        "Highlight special offers, announcements, or promotions to visitors",
    "img": Assets.imagesCustompromo,
    "ontap": () {
      Get.back();
      Get.bottomSheet(PromoBanner(), isScrollControlled: true);
    },
  },
  {
    "title": "Promo Pop Up",
    "desc":
        "A temporary window displaying promotions or messages over website content",
    "img": Assets.imagesCustompromo,
    "ontap": () {
      Get.back();
      Get.bottomSheet(
          PromoBanner(
            title: 'Pop Up Ad Editor',
            buttonText: 'Save banner',
          ),
          isScrollControlled: true);
    },
  },
  {
    "title": "Collections",
    "desc": "Showcase your favorite collections of products and services",
    "img": Assets.imagesCustomcollection2,
    "ontap": () {
      Get.back();
      Get.bottomSheet(
          SearchCriteriaProducts(
            title: 'Search Collections',
            hintText: 'Search collections',
            isMainMenu: true,
          ),
          isScrollControlled: true);
    },
  },
  {
    "title": "Squad",
    "desc": "Add your squad's favorite products to your storefront",
    "img": Assets.imagesCustomsquad2,
    "ontap": () {
      Get.back();
      Get.bottomSheet(
          SearchCriteriaProducts(
            title: 'Search Squads',
            hintText: 'Search Squads',
            isMainMenu: true,
            isSquad: true,
          ),
          isScrollControlled: true);
    },
  },
  {
    "title": "Media",
    "desc": "Add photos, videos, GIFs, and the like to your storefront",
    "img": Assets.imagesCustommedia,
    "ontap": () {
      Get.bottomSheet(AddPdp(), isScrollControlled: true);
    },
  },
];

class _AddPageSectionState extends State<AddPageSection> {
  void _addSection(Map<String, dynamic> newSection) async {
    final provider = context.read<PagesProvider>();
    final page = provider.currentPage;

    if (page == null) {
      Get.back();
      return;
    }

    final sections = (page.sections ?? []).map((s) => s.toJson()).toList();

    if (widget.insertIndex != null && widget.insertIndex! <= sections.length) {
      sections.insert(widget.insertIndex!, newSection);
    } else {
      sections.add(newSection);
    }

    // Re-order
    for (int i = 0; i < sections.length; i++) {
      sections[i]["order"] = i;
    }

    final updateId = page.id ?? widget.pageId;

    if (updateId == null || updateId.isEmpty) {
      AlertInfo.show(context: context, text: "Page ID not found.");
      return;
    }

    await provider.updatePage(
      id: updateId,
      sections: sections,
    );
    Get.back();
    AlertInfo.show(context: context, text: "Section added successfully");
  }

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
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  add_section_row(
                    title: "Recent Products",
                    desc:
                        "Rivale will automatically feature all of your recently added products to this section",
                    img: Assets.imagesCustomproduct2,
                    ontap: () => _addSection({
                      "title": "Recent Products",
                      "type": "RECENT_PRODUCTS",
                      "isVisible": true,
                      "settings": {"heading": "Recent Products"}
                    }),
                    delay: 150,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Recent Likes",
                    desc:
                        "Rivale will automatically feature all of your recently liked posts to this section",
                    img: Assets.imagesCustomlike,
                    ontap: () {
                      Get.back();
                      AlertInfo.show(context: context, text: "Coming soon!");
                    },
                    delay: 300,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Recent Shares",
                    desc:
                        "Rivale will automatically feature all of your recently shared posts to this section",
                    img: Assets.imagesCustomsharw,
                    ontap: () {
                      Get.back();
                      AlertInfo.show(context: context, text: "Coming soon!");
                    },
                    delay: 450,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Promo Banner",
                    desc:
                        "Highlight special offers, announcements, or promotions to visitors",
                    img: Assets.imagesCustompromo,
                    ontap: () {
                      Get.back();
                      Get.bottomSheet(PromoBanner(), isScrollControlled: true);
                    },
                    delay: 600,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Promo Pop Up",
                    desc:
                        "A temporary window displaying promotions or messages over website content",
                    img: Assets.imagesCustompromo,
                    ontap: () {
                      Get.back();
                      Get.bottomSheet(
                          PromoBanner(
                            title: 'Pop Up Ad Editor',
                            buttonText: 'Save banner',
                          ),
                          isScrollControlled: true);
                    },
                    delay: 750,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Collections",
                    desc:
                        "Showcase your favorite collections of products and services",
                    img: Assets.imagesCustomcollection2,
                    ontap: () {
                      Get.bottomSheet(
                          SearchCriteriaProducts(
                            title: 'Search Collections',
                            hintText: 'Search collections',
                            isMainMenu: true,
                            onItemSelected: (item) {
                              if (item != null) {
                                final col = item as CollectionModel;
                                _addSection({
                                  "title": col.name ?? "Collection",
                                  "type": "COLLECTION",
                                  "isVisible": true,
                                  "settings": {
                                    "heading": col.name,
                                    "collectionId": col.id
                                  },
                                  "products": (col.products ?? [])
                                      .map((p) => p.toJson())
                                      .toList(),
                                });
                              }
                            },
                          ),
                          isScrollControlled: true);
                    },
                    delay: 900,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Squad",
                    desc:
                        "Add your squad's favorite products to your storefront",
                    img: Assets.imagesCustomsquad2,
                    ontap: () {
                      Get.bottomSheet(
                          SearchCriteriaProducts(
                            title: 'Search Squads',
                            hintText: 'Search Squads',
                            isMainMenu: true,
                            isSquad: true,
                            onItemSelected: (item) {
                              if (item != null) {
                                final squad = item as SquadModel;
                                _addSection({
                                  "title": squad.name ?? "Squad",
                                  "type": "SQUAD",
                                  "isVisible": true,
                                  "settings": {
                                    "heading": squad.name,
                                    "squadId": squad.id,
                                    "members": (squad.members ?? [])
                                        .map((m) => m.toJson())
                                        .toList(),
                                  }
                                });
                              }
                            },
                          ),
                          isScrollControlled: true);
                    },
                    delay: 1050,
                  ),
                  SizedBox(height: 15),
                  add_section_row(
                    title: "Media",
                    desc:
                        "Add photos, videos, GIFs, and the like to your storefront",
                    img: Assets.imagesCustommedia,
                    ontap: () {
                      _addSection({
                        "title": "Media",
                        "type": "MEDIA",
                        "isVisible": true,
                        "settings": {"image": "", "heading": "Media"}
                      });
                    },
                    delay: 1200,
                  ),
                ],
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
