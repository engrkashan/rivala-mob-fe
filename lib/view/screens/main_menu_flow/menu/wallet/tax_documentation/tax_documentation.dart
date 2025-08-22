import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class TaxDocumentation extends StatefulWidget {
  const TaxDocumentation({super.key});

  @override
  State<TaxDocumentation> createState() => _TaxDocumentationState();
}

class _TaxDocumentationState extends State<TaxDocumentation> {
  bool isBusiness = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,title: 'Tax Documents', centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                // Toggle Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CustomCheckBox(
                          isActive: isBusiness,
                          onTap: () {
                            setState(() {
                              isBusiness = true;
                            });
                          },
                          iscircle: true,
                          borderColor: kblack,
                          selectedColor: kwhite,
                          iconColor: kblack,
                          unSelectedColor: kwhite,
                        ),
                        MyText(
                          text: 'Business',
                          size: 15,
                          weight: FontWeight.w500,
                          color: kblack,
                          paddingLeft: 5,
                        )
                      ],
                    ),
                    const SizedBox(width: 25),
                    Row(
                      children: [
                        CustomCheckBox(
                          isActive: !isBusiness,
                          onTap: () {
                            setState(() {
                              isBusiness = false;
                            });
                          },
                          iscircle: true,
                          borderColor: kblack,
                          selectedColor: kwhite,
                          iconColor: kblack,
                          unSelectedColor: kwhite,
                        ),
                        MyText(
                          text: 'Personal',
                          size: 15,
                          weight: FontWeight.w500,
                          color: kblack,
                          paddingLeft: 5,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Conditional Fields
                if (isBusiness) ...[
                  MyTextField(
                    hint: '1234567890',
                    label: 'EIN',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                  MyText(
                    text: 'Business Name',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                  ),
                  MyText(
                    text: '*if different than name',
                    fontStyle: FontStyle.italic,
                    color: kblack,
                    size: 9,
                    paddingBottom: 8,
                  ),
                  MyTextField(
                    hint: 'Nutrition Rescue',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                  MyTextField(
                    hint: '123 N 456 S, Bountiful Utah, 84108',
                    label: 'Business Address',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                    SizedBox(height: 100,),
                  row_widget(
              icon: Assets.imagesExport2,
              iconSize: 18,
              title: 'Export 1099',
              textColor: kblue,
            ),
                ] else ...[
                  MyTextField(
                    hint: '123-45-6789',
                    label: 'Social Security',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                  MyText(
                    text: 'Name',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                  ),
                  MyText(
                    text: '*if different than name',
                    fontStyle: FontStyle.italic,
                    color: kblack,
                    size: 9,
                    paddingBottom: 8,
                  ),
                  MyTextField(
                    hint: 'Nutrition Rescue',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                  MyTextField(
                    hint: '123 Elm Street, Apt 4B, New York, NY, 10001',
                    label: 'Address',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                  SizedBox(height: 100,),
                  row_widget(
              icon: Assets.imagesExport2,
              iconSize: 18,
              title: 'Export 1099',
              textColor: kblue,
            ),
                ],
              ],
            ),
          ),

       
        ],
      ),
    );
  }
}

