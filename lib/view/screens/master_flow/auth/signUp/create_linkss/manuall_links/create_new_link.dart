import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/import_linktree/import_linktree.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/import_linktree/import_linktree_email.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/link_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/indiviual_link.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

class CreateNewLink extends StatefulWidget {
  final String? title;
  final bool? hasAddOpt, hasDelete;
  const CreateNewLink(
      {super.key, this.title, this.hasAddOpt = false, this.hasDelete = false});

  @override
  State<CreateNewLink> createState() => _IndiviualLinkState();
}

class _IndiviualLinkState extends State<CreateNewLink> {
  List<Map<String, String>> linkItems = [
    {"title": "Instagram", "link": "instagram.com/austinlarsen27"},
    {"title": "TikTok", "link": "tiktok.com/austinlarsen"},
    {"title": "Shopify", "link": "rivala.com/shop"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: widget.title ?? 'Add Your Links',
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                if (widget.hasAddOpt == true)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        row_widget(
                          onTap: () {
                            Get.to(() => IndiviualLink());
                          },
                          icon: Assets.imagesAdd3,
                          title: ' Add new link',
                          iconSize: 22,
                          texSize: 12,
                          weight: FontWeight.bold,
                        ),
                        row_widget(
                          onTap: () {
                            Get.to(() => ImportLinktreeEmail());
                          },
                          icon: Assets.imagesLinktree,
                          title: ' Import from LinkTree',
                          iconSize: 22,
                          texSize: 12,
                          weight: FontWeight.bold,
                          textColor: kblue,
                        ),
                      ],
                    ),
                  ),
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
                        isDelete: widget.hasDelete,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                //add_link_container(),
                if (widget.hasAddOpt == false)
                  MyText(
                      paddingTop: 15,
                      text: '+ Add new link',
                      size: 15,
                      paddingBottom: 90,
                      weight: FontWeight.w400,
                      color: kblue),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.hasAddOpt == false
          ? MyButton(
              buttonText: 'Done with links',
              mBottom: 50,
              mhoriz: 35,
              onTap: () {
                Get.to(() => MAsterLinkSuccess());
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class add_link_container extends StatelessWidget {
  final int? delay;
  final String? title, link, editButtontext;
  final bool? isRadio, isMainMenu, isDelete;
  final VoidCallback? onEditTap;
  final double? text1Size, text2Size;
  final int? maxlines;
  const add_link_container({
    super.key,
    this.delay,
    this.title,
    this.link,
    this.isRadio = false,
    this.isMainMenu = false,
    this.editButtontext,
    this.onEditTap,
    this.text1Size,
    this.text2Size,
    this.maxlines,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        MoveEffect(delay: Duration(milliseconds: delay ?? 200)),
        FadeEffect(duration: Duration(milliseconds: 300)),
        SlideEffect(delay: Duration(milliseconds: 200))
      ],
      child: CustomeContainer(
        vpad: 19,
        hpad: 15,
        radius: 15,
        mtop: 0,
        hasShadow: true,
        color: kwhite,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMainMenu == false)
              Bounce_widget(
                  widget: Image.asset(
                Assets.imagesMenu,
                width: 11,
                height: 11,
              )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          paddingTop: 20,
                          text: title ?? 'Instagram ',
                          size: text1Size ?? 15,
                          paddingBottom: 8,
                          weight: FontWeight.w500,
                          color: kblack),
                      MyText(
                          text: link ?? 'tiktok.com/austinlarsen',
                          size: text2Size ?? 15,
                          weight: FontWeight.w300,
                          maxLines: maxlines ?? 1,
                          textOverflow: TextOverflow.ellipsis,
                          color: kblack),
                      if (isRadio == false || isMainMenu == true)
                        Bounce_widget(
                          ontap: onEditTap ??
                              () {
                                Get.to(() => IndiviualLink());
                              },
                          widget: MyText(
                            paddingTop: 20,
                            text: editButtontext ?? '> Edit link',
                            size: 12,
                            paddingBottom: 8,
                            weight: FontWeight.w500,
                            color: kblue,
                          ),
                        ),
                      if (isDelete == true)
                        Bounce_widget(
                          ontap: () {
                            Get.to(() => IndiviualLink());
                          },
                          widget: MyText(
                            text: editButtontext ?? 'Delete Link',
                            size: 12,
                            paddingBottom: 8,
                            weight: FontWeight.w500,
                            color: kred,
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                if (isRadio == false && isMainMenu == false) SwitchButton(),
                if (isRadio == true && isMainMenu == false)
                  CustomCheckBox(
                    isActive: true,
                    onTap: () {},
                    iscircle: true,
                    iconColor: ktertiary,
                    selectedColor: kwhite,
                    bordercolor2: ktertiary,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
