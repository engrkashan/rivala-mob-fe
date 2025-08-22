import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class StoreFotter extends StatelessWidget {
  const StoreFotter({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
                color: kheader,
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.imagesApolo2,
                      width: 63,
                      height: 63,
                    ),
                    MyText(
                      text: 'This is Apollo and Sage',
                      color: kwhite,
                      size: 18,
                      weight: FontWeight.w600,
                      paddingBottom: 15,
                      paddingTop: 20,
                      useCustomFont: true,
                    ),
                    MyText(
                      text:
                          'Designed and created for the outdoor lovers who are searching for sunshine filled coastlines, beachfront cafés and crystal blue waves.',
                      color: kwhite,
                      size: 14,
                      weight: FontWeight.w400,
                      paddingBottom: 25,
                      useCustomFont: true,
                    ),
                    MyText(
                      text: 'Privacy Policy',
                      color: ksubHeader,
                      size: 13,
                      weight: FontWeight.w600,
                      paddingBottom: 10,
                      paddingTop: 20,
                      useCustomFont: true,
                    ),
                    MyText(
                      text: 'Shipping & Returns',
                      color: ksubHeader,
                      size: 13,
                      weight: FontWeight.w600,
                      paddingBottom: 10,
                      useCustomFont: true,
                    ),
                    MyText(
                      text: 'Frequently Asked Questions',
                      color: ksubHeader,
                      size: 13,
                      weight: FontWeight.w600,
                      paddingBottom: 10,
                      useCustomFont: true,
                    ),
                    MyText(
                      paddingTop: 60,
                      text: '© 2023 Apollo & Sage\nAll rights reserved',
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