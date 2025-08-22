import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/squads/add_squad_members.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/set_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

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
    "ontap": () {
   Get.bottomSheet(AddSquadMembers(
    isLimit: true,
    isProduct: false,
   ),isScrollControlled: true);
    },
  },
  {
    "title": "Sellers",
    "link":
        "Members of the squad will not receive a commission for any products sold by a seller in this list.",
    "editButton": "+ Add Brand",
    "ontap": () {
     
    },
  },
  {
    "title": "Products",
    "link":
        "Commissions earned for any product on this list will be automatically credited to this squad",
    "editButton": "+ Add Product",
    "ontap": () {
    Get.bottomSheet(AddSquadMembers(
    title: 'Add Product',
    hint: 'Search products',
    isProduct: true,
   ),isScrollControlled: true);
    },
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Squads', centerTitle: true),
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
                  EditImgStack(),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    label: 'Squad Name',
                    hint: 'American Fork Football 2025',
                    filledColor: kblack.withOpacity(0.04),
                    bordercolor: ktransparent,
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
                                text: '20/100',
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
                    label: 'Summary',
                    hint:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                    filledColor: kblack.withOpacity(0.04),
                    bordercolor: ktransparent,
                    maxLines: 5,
                    delay: 250,
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
                                text: '20/100',
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: add_link_container(
                            title: newSquad[index]["title"]!,
                            link: newSquad[index]["link"]!,
                            editButtontext: newSquad[index]["editButton"]!,
                            onEditTap: newSquad[index]["ontap"]!,
                            delay: (index + 1) * 200,
                            text2Size: 11,
                            maxlines: 3,
                            isMainMenu: true),
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
