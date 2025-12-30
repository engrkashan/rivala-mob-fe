import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/promo_code.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddCriteria extends StatelessWidget {
  const AddCriteria({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> criteriaList = [
      {
        'title': 'Promo Code',
        'desc':
            'A promo code is a unique code providing discounts or promotions at checkout.',
        'icon': Assets.imagesTags2,
        'ontap': () {
          Get.back();
          Get.bottomSheet(
              PromoCode(
                isPromo: true,
              ),
              isScrollControlled: true);
        }
      },
      {
        'title': 'For a Product',
        'desc':
            'A tailored price reduction emphasizing a product’s exclusive benefits.',
        'icon': Assets.imagesProduct,
        'ontap': () {
          Get.back();
          Get.bottomSheet(
              PromoCode(
                title: 'Product Promo',
                isPromo: true,
              ),
              isScrollControlled: true);
        }
      },
      {
        'title': 'For a Collection',
        'desc':
            'Exclusive discount tailored to a distinct, one-of-a-kind product collection',
        'icon': Assets.imagesCollection,
        'ontap': () {
          Get.back();
          Get.bottomSheet(
              PromoCode(
                title: 'Collection Promo',
                isPromo: true,
              ),
              isScrollControlled: true);
        }
      },
      {
        'title': 'Minimum Purchase Amount',
        'desc':
            'Lowest spending required to qualify for a promotion or discount.',
        'icon': Assets.imagesPurchase,
        'ontap': () {
          Get.back();
          Get.bottomSheet(
              PromoCode(
                isPromo: true,
                title: 'Min/Max Purchase',
                isMinMax: true,
              ),
              isScrollControlled: true);
        }
      },
      {
        'title': 'Maximum Purchase Amount',
        'desc':
            'Highest spending limit allowed for a promotion or offer eligibility.',
        'icon': Assets.imagesPurchase,
        'ontap': () {}
      },
      {
        'title': 'Maximum Promotion Uses',
        'desc':
            'Highest spending limit allowed for a promotion or offer eligibility.',
        'icon': Assets.imagesPurchase,
        'ontap': () {}
      },
    ];
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: kwhite),
      padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: MyText(
                text: 'Add Criteria',
                size: 15,
                weight: FontWeight.w500,
              )),
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose2,
                    width: 22,
                    height: 22,
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // To avoid scroll conflict
            itemCount: criteriaList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: add_criteria_row(
                  title: criteriaList[index]['title'],
                  desc: criteriaList[index]['desc'],
                  icon: criteriaList[index]['icon'],
                  ontap: criteriaList[index]['ontap'],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class add_criteria_row extends StatelessWidget {
  final String? title, desc, icon;
  final VoidCallback? ontap;
  const add_criteria_row({
    super.key,
    this.title,
    this.desc,
    this.icon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: Row(
        children: [
          CustomeContainer(
            borderColor: ktertiary,
            radius: 8,
            color: kgreen.withOpacity(0.09),
            vpad: 8,
            hpad: 8,
            widget: Image.asset(
              icon ?? Assets.imagesTags2,
              width: 21,
              height: 21,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: TwoTextedColumn(
            text1: title ?? 'Promo Code',
            text2: desc ??
                'A promo code is a unique code providing discounts or promotions at checkout.',
            color2: kgrey3,
            size1: 15,
            size2: 10,
            mBottom: 0,
            weight1: FontWeight.w500,
            weight2: FontWeight.w500,
          ))
        ],
      ),
    );
  }
}
