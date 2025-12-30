import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/squads/add_squad_members.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/set_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../controllers/providers/squads_provider.dart';
import '../../../../../widgets/image_stack.dart';

class CreateNewSquad extends StatefulWidget {
  const CreateNewSquad({super.key});

  @override
  State<CreateNewSquad> createState() => _CreateNewSquadState();
}

class _CreateNewSquadState extends State<CreateNewSquad> {
  List<Map<String, dynamic>> newSquad = [
    {
      "title": "Members",
      "link": "Total Commission: 100%",
      "editButton": "+ Invite Member",
      "type": "members", // <<< ADD THIS
      "ontap": () {
        Get.bottomSheet(
          AddSquadMembers(
            isLimit: true,
            isProduct: false,
            isBrand: false,
          ),
          isScrollControlled: true,
        );
      },
    },
    {
      "title": "Sellers",
      "link":
          "Members of the squad will not receive a commission for any products sold by a seller in this list.",
      "editButton": "+ Add Brand",
      "type": "sellers", // optional
      "ontap": () {
        Get.bottomSheet(
          AddSquadMembers(
            title: "Add Brand",
            hint: "Search brands",
            isLimit: true,
            isProduct: false,
            isBrand: true,
          ),
          isScrollControlled: true,
        );
      },
    },
    {
      "title": "Products",
      "link":
          "Commissions earned for any product on this list will be automatically credited to this squad",
      "editButton": "+ Add Product",
      "type": "products", // optional
      "ontap": () {
        Get.bottomSheet(
          AddSquadMembers(
            title: 'Add Product',
            hint: 'Search products',
            isProduct: true,
            isBrand: false,
          ),
          isScrollControlled: true,
        );
      },
    },
  ];

  final squadName = TextEditingController();
  final squadSummary = TextEditingController();
  int nameCount = 0;
  int summaryCount = 0;

  @override
  Widget build(BuildContext context) {
    final squadMember = context.watch<SquadProvider>();
    final sellersProvider = context.watch<BrandsProvider>();
    final prdProvider = context.watch<ProductProvider>();
    final memberImages = squadMember.selectedMembers
        .map((e) => e.avatarUrl)
        .whereType<String>()
        .where((e) => e.isNotEmpty)
        .toList();

    final sellerImages = sellersProvider.filteredStores
        .map((e) => e.logoUrl)
        .whereType<String>()
        .where((e) => e.isNotEmpty)
        .toList();

    final prdImages = prdProvider.filteredPrds
            ?.map((e) => e.image?.isNotEmpty == true ? e.image!.first : null)
            .whereType<String>()
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    print(memberImages.toList());
    print("Seller Images: ${sellerImages.toList()}");
    print("Product Images: ${prdImages?.toList()}");
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context, title: 'Squads', centerTitle: true),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 22),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      EditImgStack(),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        label: 'Squad Name',
                        hint: 'American Fork Football 2025',
                        controller: squadName,
                        filledColor: kblack.withOpacity(0.04),
                        bordercolor: ktransparent,
                        onChanged: (e) {
                          nameCount = e.length;
                          setState(() {});
                        },
                        suffixIcon: SizedBox(
                          height: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyText(
                                    text: '$nameCount/100',
                                    color: ktertiary,
                                    paddingRight: 3,
                                  ),
                                  Image.asset(
                                    Assets.imagesCheckbox,
                                    width: 15,
                                    height: 15,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      MyTextField(
                        controller: squadSummary,
                        label: 'Summary',
                        hint: "Squad summary or description",
                        filledColor: kblack.withOpacity(0.04),
                        bordercolor: ktransparent,
                        maxLines: 5,
                        delay: 250,
                        onChanged: (e) {
                          summaryCount = e.length;
                          setState(() {});
                        },
                        suffixIcon: SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyText(
                                    text: '$summaryCount/100',
                                    color: ktertiary,
                                    paddingRight: 3,
                                  ),
                                  Image.asset(
                                    Assets.imagesCheckbox,
                                    width: 15,
                                    height: 15,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newSquad.length,
                        itemBuilder: (context, index) {
                          final item = newSquad[index];

                          // Select correct images based on type
                          List<String?> images = [];

                          if (item["type"] == "members") {
                            images = memberImages;
                          } else if (item["type"] == "sellers") {
                            images = sellerImages;
                          } else if (item["type"] == "products") {
                            images = prdImages ?? [];
                          } else {
                            images = [];
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                add_link_container(
                                  title: item["title"]!,
                                  link: item["link"]!,
                                  editButtontext: item["editButton"]!,
                                  onEditTap: item["ontap"]!,
                                  delay: (index + 1) * 200,
                                  text2Size: 11,
                                  maxlines: 3,
                                  isMainMenu: true,
                                  leadingWidget: images.isNotEmpty
                                      ? StackedImagesWidget(
                                          urlImages: images
                                              .whereType<String>()
                                              .toList(),
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 200,
                        child: MyButton(
                          buttonText: "Add Squad",
                          onTap: () {
                            squadMember.sendSquadRequest(
                                squadName.text, squadSummary.text, context);
                            if (squadMember.error != null) {
                              print("squad error: ${squadMember.error}");
                              AlertInfo.show(
                                  context: context, text: squadMember.error!);
                              return;
                            }
                            Navigator.pop(context);
                          },
                          height: 50,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (squadMember.isLoading)
              Positioned.fill(
                  child: Container(
                color: Colors.grey,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
          ],
        ));
  }
}
