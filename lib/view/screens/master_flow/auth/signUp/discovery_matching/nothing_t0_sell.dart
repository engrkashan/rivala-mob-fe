import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/show_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/discovery_animation.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import 'product_setup_success.dart';

class NothingToSell extends StatefulWidget {
  const NothingToSell({super.key});

  @override
  State<NothingToSell> createState() => _NothingToSellState();
}

class _NothingToSellState extends State<NothingToSell> {
  List<String> categories = [
    'Wellness', 'Sports', 'Travel', 'Beauty', 'Apparel', 
    'Photography', 'Creative', 'Services', 'Experiences'
  ];

  Set<String> selectedCategories = {}; // Allow multiple selections

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,centerTitle: true, actions: [
        Bounce_widget(
          ontap: () {
            Get.to(() => GradientSuccessScreen());
          },
          widget: Text(
            'Skip',
            style: TextStyle(
              shadows: [Shadow(color: ktertiary, offset: Offset(0, -3))],
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decorationColor: ktertiary,
              decorationThickness: 1,
              decorationStyle: TextDecorationStyle.solid,
              fontFamily: AppFonts.poppins,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(width: 12),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              physics: const BouncingScrollPhysics(),
              children: [
                DiscoveryAnimation(),
                MyText(
                  paddingTop: 40,
                  text: 'Any particular interests?',
                  size: 24,
                  paddingBottom: 10,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w600,
                  color: kblack2,
                ),
                MyText(
                  text: 'We’ll show you accounts and products that match your interests',
                  size: 14,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w400,
                  paddingBottom: 25,
                  color: kblack2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 12,
                    children: categories.map((category) {
                      bool isSelected = selectedCategories.contains(category);
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width - 64) / 3,
                        child: buttonContainer(
                          text: category,
                          bgColor: isSelected ? ktertiary : ktransparent,
                          borderColor: isSelected ? ktertiary : ktertiary,
                          txtColor: isSelected ? kwhite : ktertiary,
                          radius: 50,
                          vPadding: 10,
                          hPadding: 6,
                          textsize: 10,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedCategories.remove(category);
                              } else {
                                selectedCategories.add(category);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
          Mybutton2(
            buttonText: 'Show me some cool products!',
            mbot: 30,
            hpad: 22,
            ontap:(){
              Get.to(()=>ShowProducts());
            },
          ),
        ],
      ),
    );
  }
}
