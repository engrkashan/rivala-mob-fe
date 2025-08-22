import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/add_criteria.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class StartNewPromo extends StatefulWidget {
  final Color? color;
  final String? buttonText;
  const StartNewPromo({super.key, this.color, this.buttonText});

  @override
  State<StartNewPromo> createState() => _StartNewPromoState();
}

class _StartNewPromoState extends State<StartNewPromo> {
  int selectedIndex = 1; // 0 for Creators, 1 for Sellers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar:
          simpleAppBar(context: context,title: 'Start New Promo', centerTitle: true, actions: [
        Bounce_widget(
          widget: Image.asset(
            Assets.imagesClose,
            width: 18,
            height: 18,
          ),
        ),
        const SizedBox(width: 12),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  text: 'Who’s this promo for?',
                  size: 17,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                  color: kblack,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                /// **Row with Equal Size Containers**
                Row(
                  children: [
                    Expanded(
                      child: Bounce_widget(
                        ontap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        widget: CustomeContainer(
                          borderColor:
                              selectedIndex == 0 ? ktransparent :widget.color?? kgreen,
                          color: selectedIndex == 0 ?widget.color?? kblue : ktransparent,
                          radius: 15,
                          widget: Column(
                            children: [
                              Image.asset(
                                Assets.imagesCreator,
                                height: 37,
                                width: 35,
                                color: selectedIndex == 0 ? kwhite : kblack,
                              ),
                              MyText(
                                text: 'CREATORS',
                                size: 18,
                                weight: FontWeight.bold,
                                color: selectedIndex == 0 ? kwhite : kblack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Bounce_widget(
                        ontap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        widget: CustomeContainer(
                          borderColor:
                              selectedIndex == 1 ? ktransparent :widget.color?? kgreen,
                          color: selectedIndex == 1 ?widget.color?? kblue : ktransparent,
                          radius: 15,
                          widget: Column(
                            children: [
                              Image.asset(
                                Assets.imagesSeller,
                                height: 37,
                                width: 35,
                                color: selectedIndex == 1 ? kwhite : kblack,
                              ),
                              MyText(
                                text: 'SELLERS',
                                size: 18,
                                weight: FontWeight.bold,
                                color: selectedIndex == 1 ? kwhite : kblack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 34),
                MyTextField(
                  hint: 'Black Friday',
                  label: 'Promo Name',
                  suffixIcon: Image.asset(
                    Assets.imagesEdit,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  delay: 200,
                  filledColor: kblack.withOpacity(0.05),
                  bordercolor: ktransparent,
                ),
                MyTextField(
                  hint:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                  label: 'Description',
                  suffixIcon: Image.asset(
                    Assets.imagesEdit,
                    width: 20,
                    height: 20,
                  ),
                  maxLines: 4,
                  delay: 400,
                  filledColor: kblack.withOpacity(0.05),
                  bordercolor: ktransparent,
                ),
                MyTextField(
                  hint: 'MM/DD/YYYY',
                  label: 'Start Date',
                  filledColor: kblack.withOpacity(0.05),
                  suffixIcon: Image.asset(
                    Assets.imagesCalender,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  delay: 600,
                  bordercolor: ktransparent,
                ),
                MyTextField(
                  hint: 'MM/DD/YYYY',
                  label: 'End Date',
                  filledColor: kblack.withOpacity(0.05),
                  suffixIcon: Image.asset(
                    Assets.imagesCalender,
                    width: 20,
                    height: 20,
                  ),
                  delay: 800,
                  bordercolor: ktransparent,
                ),
                CustomDropDown(
                  delay: 1000,
                  label: 'Status',
                  hint: 'Live',
                  items: ['Off', 'Paused', 'Live'],
                  selectedValue: 'Live',
                  onChanged: (e) {},
                ),
                MyText(
                  text: 'Criteria #1',
                  size: 15,
                  weight: FontWeight.w500,
                  color: kblack,
                  paddingBottom: 15,
                ),
                Container(
                  height: Get.height*0.2,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          MyText(
                            text: 'IF',
                            color: kblack,
                            weight: FontWeight.w700,
                            size: 20,
                            paddingRight: 5,
                          ),
                          Image.asset(
                            Assets.imagesIfIcon,
                            width: 34,
                            height: 34,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: CustomeContainer(
                              radius: 15,
                              vpad: 10,
                              hpad: 12,
                              color: kblack.withOpacity(0.05),
                              widget: MyText(
                                text:
                                    'The minimum purchase amount is at least \$100.00',
                                size: 14,
                                color: ktertiary,
                              ),
                            ),
                          )
                        ],
                      ),
                      // Positioned(
                      //   left: 40,
                      //   child: Image.asset(Assets.imagesGradline,width: 4,height: 93,)),
                         Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                           child: Row(
                                             children: [
                                               MyText(
                                                 text: 'THEN',
                                                 color: kblack,
                                                 weight: FontWeight.w700,
                                                 size: 10,
                                                 paddingRight: 5,
                                               ),
                                               Image.asset(
                                                 Assets.imagesThen,
                                                 width: 34,
                                                 height: 34,
                                               ),
                                               SizedBox(
                                                 width: 12,
                                               ),
                                               Expanded(
                                                 child: CustomeContainer(
                            radius: 15,
                            vpad: 10,
                            hpad: 12,
                            color: kblack.withOpacity(0.05),
                            widget: MyText(
                              text:
                                  'Discount shipping by 20%',
                              size: 14,
                              color: ktertiary,
                            ),
                                                 ),
                                               )
                                             ],
                                           ),
                         ),
                    ],
                  ),
                ),

 
                MyText(
                  text: '+ Add criteria',
                  size: 12,
                  color: kblue,
                  onTap: () {
                    Get.bottomSheet(AddCriteria(), isScrollControlled: true);
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          MyButton(
            buttonText:widget.buttonText?? 'Add & save promo',
            mBottom: 30,
            mhoriz: 22,
            onTap: () {
              Get.back();
              // Get.to(() => StartNewPromoSuccess());
            },
          ),
        ],
      ),
    );
  }
}
