import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../models/store_model.dart';

class StoreFotter extends StatelessWidget {
  final StoreModel? store;
  const StoreFotter({super.key, this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kheader,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CommonImageView(
              url: store?.logoUrl,
              width: 63,
              height: 63,
            ),
          ),
          MyText(
            text: 'This is ${store?.name}',
            color: kwhite,
            size: 18,
            weight: FontWeight.w600,
            paddingBottom: 15,
            paddingTop: 20,
            useCustomFont: true,
          ),
          MyText(
            text: "${store?.owner?.bio}",
            // 'Designed and created for the outdoor lovers who are searching for sunshine filled coastlines, beachfront cafés and crystal blue waves.',
            color: kwhite,
            size: 14,
            weight: FontWeight.w400,
            paddingBottom: 25,
            useCustomFont: true,
          ),
          // MyText(
          //   text: 'Privacy Policy',
          //   color: ksubHeader,
          //   size: 13,
          //   weight: FontWeight.w600,
          //   paddingBottom: 10,
          //   paddingTop: 20,
          //   useCustomFont: true,
          // ),
          // MyText(
          //   text: 'Shipping & Returns',
          //   color: ksubHeader,
          //   size: 13,
          //   weight: FontWeight.w600,
          //   paddingBottom: 10,
          //   useCustomFont: true,
          // ),
          // MyText(
          //   text: 'Frequently Asked Questions',
          //   color: ksubHeader,
          //   size: 13,
          //   weight: FontWeight.w600,
          //   paddingBottom: 10,
          //   useCustomFont: true,
          // ),
          MyText(
            paddingTop: 60,
            text: '© ${store?.name}\nAll rights reserved',
            color: kwhite, //ksubHeader,
            size: 13,
            weight: FontWeight.w500,
            useCustomFont: true,
            paddingBottom: 100,
          ),
        ],
      ),
    );
  }
}
