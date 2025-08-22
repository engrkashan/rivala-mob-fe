import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_tags.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddSquadMembers extends StatelessWidget {
  final String? title, hint;
  final bool? isLimit, isProduct;
  const AddSquadMembers(
      {super.key,
      this.title,
      this.isLimit = false,
      this.hint,
      this.isProduct = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: kwhite),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: title ?? 'Add Member',
                      size: 15,
                      color: kblack,
                      weight: FontWeight.w500,
                    ),
                    if (isLimit == true)
                      row_widget(
                        icon: Assets.imagesAlert2,
                        iconSize: 12,
                        title: 'You’ve reached the max number of members',
                        textColor: kred,
                        texSize: 10,
                        fontstyle: FontStyle.italic,
                      )
                  ],
                ),
              ),
              Bounce_widget(
                  ontap: () {
                        Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose2,
                    width: 20,
                  ))
            ],
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            radius: 50,
            contentvPad: 5,
            hint: hint ?? 'Search users',
            prefixIcon: Image.asset(
              Assets.imagesSearch,
              width: 12,
            ),
          ),
          if (isProduct == false)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: add_members_row(),
                );
              },
            ),
          if (isProduct == true)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, switchIndex) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: tags_search_row(
                      size: 54,
                      hpad: 0,
                      bgColor: ktransparent,
                      image: Assets.imagesDummyimage2,
                      title: 'Blue Floral Short',
                      tags: 'Apollo and Sage',
                    ));
              },
            ),
        ],
      ),
    );
  }
}

//

class add_members_row extends StatefulWidget {
  final String? title, img;

  const add_members_row({
    super.key,
    this.title,
    this.img,
  });

  @override
  State<add_members_row> createState() => _add_members_rowState();
}

class _add_members_rowState extends State<add_members_row> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageView(
          imagePath: Assets.imagesNutrition2,
          width: 54,
          height: 54,
          radius: 100,
        ),
        Expanded(
            child: MyText(
          text: 'Nutrition Rescue',
          size: 15,
          weight: FontWeight.w500,
          paddingLeft: 9,
        )),
        Bounce_widget(
            ontap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            widget: Image.asset(
              isSelected ? Assets.imagesCheckmark : Assets.imagesAdd,
              width: 22,
            ))
      ],
    );
  }
}
