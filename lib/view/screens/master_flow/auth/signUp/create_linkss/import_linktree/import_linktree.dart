import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';

class ImportLinktree extends StatefulWidget {
  const ImportLinktree({super.key});

  @override
  State<ImportLinktree> createState() => _IndiviualLinkState();
}

class _IndiviualLinkState extends State<ImportLinktree> {
  List<Map<String, String>> linkItems = [
    {"title": "Instagram", "link": "instagram.com/austinlarsen27"},
    {"title": "TikTok", "link": "tiktok.com/austinlarsen"},
    {"title": "Shopify", "link": "rivala.com/shop"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context,title: 'Import from LinkTree', centerTitle: true, actions: [
          Bounce_widget(
              widget: Image.asset(
            Assets.imagesClose,
            width: 18,
            height: 18,
          )),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [

                  Image.asset(Assets.imagesLinktree,width: 95,height: 95,fit: BoxFit.contain,),
                  SizedBox(height: 30,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: linkItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: add_link_container(
                          title: linkItems[index]["title"]!,
                          link: linkItems[index]["link"]!,
                          delay: (index + 1) * 200,
                          isRadio: true,
                        ),
                      );
                    },
                  ),

           
                ],
              ),
            ),
            MyButton(
              buttonText: 'Add selected links',
              mBottom: 50,
              mhoriz: 35,
              onTap: () {
                Get.to(() => CreateNewLink());
              },
            ),
          ],
        ));
  }
}
