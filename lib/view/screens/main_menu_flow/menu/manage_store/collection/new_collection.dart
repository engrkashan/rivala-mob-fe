import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class NewCollection extends StatelessWidget {
  const NewCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: kwhite),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ContainerAppbar(
            title: 'New Collection',
            textColor: kblack,
            icon: Assets.imagesClose2,
          ),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              hint: 'Size',
              label: 'Collection Name',
              bordercolor: ktransparent,
              filledColor: kgrey2,
              delay: 150),
          MyTextField(
            hint:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
            label: 'Collection Description',
            bordercolor: ktransparent,
            filledColor: kgrey2,
            maxLines: 4,
            delay: 250,
          ),
          MyText(
            text: '+ Add Product to Collection',
            color: kblue,
            weight: FontWeight.w500,
            size: 12,
            paddingTop: 10,
            paddingBottom: 35,
            onTap: (){
             Get.bottomSheet(SearchCriteriaProducts(
              title: 'Add Products',
                            hasCheckbox: false,
                          ),isScrollControlled: true);
            },
          ),
          MyButton(
            buttonText: 'Save collection',
            mBottom: 30,
            onTap: () {
                  Get.back();
            },
          )
        ],
      ),
    );
  }
}
