import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/navigation/create_new_menuItem.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddNewSection extends StatefulWidget {
  const AddNewSection({super.key});

  @override
  State<AddNewSection> createState() => _AddNewSectionState();
}

class _AddNewSectionState extends State<AddNewSection> {
  final List<Map<String, dynamic>> sectionItems = [
    {
      "title": "Custom Page",
      "desc":
          "Feature one of your custom pages or an automatically generated page",
      "icon": Assets.imagesEdit4,
      "img": Assets.imagesCustompage,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Product",
      "desc": "Feature one of your favorite products!",
      "icon": Assets.imagesEdit4,
      "img": Assets.imagesCustomproduct,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Collection",
      "desc": "Feature your favorite collections!",
      "icon": Assets.imagesEdit4,
      "img": Assets.imagesCustomcollection,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Link",
      "desc": "Show people where you're hanging out!",
      "icon": Assets.imagesEdit4,
      "img": Assets.imagesCustomlink,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Squad",
      "desc": "Showcase the cool things you and your friends are doing!",
      "icon": Assets.imagesEdit4,
      "img": Assets.imagesCustomsquad,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Your Followers",
      "desc": "Show off your following with this auto-generated page",
      "icon": Assets.imagesRobot,
      "img": Assets.imagesCustomfollowing,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Who You're Following",
      "desc": "Show off who you follow with this auto-generated page",
      "icon": Assets.imagesRobot,
      "img": Assets.imagesCustomfollowing,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
    {
      "title": "Your Posts",
      "desc":
          "Feature the latest additions to your feed with this auto-generated page",
      "icon": Assets.imagesRobot,
      "img": Assets.imagesCustompost,
      "ontap": () {
        Get.to(() => CreateNewMenuitem(
              hasItems: true,
            ));
      },
    },
  ];
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
                      icon: item["icon"],
                      img: item["img"],
                      ontap: item["ontap"],
                      delay: (index + 1) * 150,
                    ),
                  );
                },
              ),
              MyButton(
                buttonText: 'Add section',
                mBottom: 0,
                onTap: () {
                      Get.back();
                },
              )
            ],
          ),
        ));
  }
}

class add_section_row extends StatelessWidget {
  final String? title, desc, icon, img;
  final int? delay;
  final VoidCallback? ontap;
  const add_section_row({
    super.key,
    this.title,
    this.desc,
    this.icon,
    this.img,
    this.ontap,
    this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: Animate(
        effects: [MoveEffect(delay: Duration(milliseconds: delay ?? 100))],
        child: Row(
          children: [
            Image.asset(
              img ?? Assets.imagesCustompage,
              width: 75,
              height: 48,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  row_widget(
                    title: title ?? 'Custom Page',
                    icon: icon,
                    isIconRight: true,
                    iconSize: icon != null ? 15 : 0,
                    texSize: 15,
                  ),
                  MyText(
                    text: desc ??
                        'Feature one of your custom pages or an automatically generated page',
                    size: 10,
                    color: kblack,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
