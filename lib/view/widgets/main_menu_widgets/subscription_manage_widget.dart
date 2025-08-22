import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/subscription/chnage_date.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/subscription/subscription_change.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/main_menu_widgets/commission_widgets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/product_desc_widgets.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class subscription_management_container extends StatefulWidget {
  final String? date, amount, savedAmount;
  final int? delay;

  const subscription_management_container({
    super.key,
    this.date,
    this.amount,
    this.savedAmount,
    this.delay,
  });

  @override
  State<subscription_management_container> createState() =>
      _subscription_management_containerState();
}

class _subscription_management_containerState
    extends State<subscription_management_container> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100))],
      child: CustomeContainer(
        color: kwhite,
        hpad: 10,
        hasShadow: true,
        radius: 15,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      MyText(
                        text: 'Next Processing Date:',
                        size: 13,
                        weight: FontWeight.w500,
                      ),
                      MyText(
                        text: widget.date ?? 'Sep. 15, 2025',
                        size: 13,
                        weight: FontWeight.w400,
                      )
                    ],
                  ),
                ),
                Bounce_widget(
                    ontap: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    widget: Icon(isActive == true
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right_rounded))
              ],
            ),
            row_widget(
              icon: Assets.imagesTruck,
              iconSize: 12,
              title: 'Shipped',
              textColor: kgreen,
              fontstyle: FontStyle.italic,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buttonContainer(
                  bgColor: kgreen,
                  imagePath: Assets.imagesGift,
                  txtColor: kwhite,
                  weight: FontWeight.w600,
                  vPadding: 2,
                  hPadding: 5,
                  textsize: 11,
                  text: 'You saved ${widget.savedAmount ?? '\$6.32'}',
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                MyText(
                  text: 'AMOUNT: ',
                  size: 11,
                  weight: FontWeight.w500,
                ),
                MyText(
                  text: widget.amount ?? '\$5,000.00',
                  size: 11,
                  weight: FontWeight.w400,
                )
              ],
            ),
            MyText(
              text: 'PRODUCT(S):',
              size: 11,
              weight: FontWeight.w500,
              paddingBottom: 10,
              paddingTop: 0,
            ),
            if (isActive == true)
              ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: subscription_sub_widget(),
                  );
                },
              ),
            if (isActive == false) ...{
              SizedBox(
                height: 10,
              ),
              horizontal_img_list()
            }
          ],
        ),
      ),
    );
  }
}

///////
class subscription_sub_widget extends StatefulWidget {
  final String? title;
  final bool? hasRadio;
  final VoidCallback? ontap;
  const subscription_sub_widget(
      {super.key, this.title, this.hasRadio = false, this.ontap});

  @override
  State<subscription_sub_widget> createState() =>
      _subscription_sub_widgetState();
}

class _subscription_sub_widgetState extends State<subscription_sub_widget> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bounce_widget(
          duration: 100,
          ontap: () {
            setState(() {
              isActive = !isActive;
            });
            if (widget.ontap != null) {
              widget.ontap!();
            }
          },
          widget: CustomeContainer(
            radius: 8,
            vpad: 0,
            hpad: 12,
            color: kblack.withOpacity(0.05),
            widget: Row(
              children: [
                if (widget.hasRadio == true) ...{
                  CustomCheckBox(
                    isActive: isActive ? true : false,
                    onTap: () {},
                    iscircle: true,
                    circleIcon: Icons.check,
                    size: 16,
                    circleIconsize: 12,
                    borderColor: kblack,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                },
                store_image_stack(
                  width: 45,
                  height: 45,
                  iconSize: 15,
                  radius: 8,
                  showShadow: false,
                  showContent: false,
                ),
                Expanded(
                    child: MyText(
                  text: 'Blue Floral Short',
                  paddingLeft: 8,
                ))
              ],
            ),
          ),
        ),
        if (isActive && widget.hasRadio == false) ...{
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CustomDropDown(
                      vpad: 2,
                      hpad: 2,
                      delay: 0,
                      radius: 8,
                      hint: 'Frequency: Monthly',
                      items: ['Weekly', 'Monthly', 'Quarterly'],
                      selectedValue: 'Weekly',
                      onChanged: (c) {})),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Bounce_widget(
                        ontap: () {
                          Navigator.of(context).push(
                            CustomPageRoute(page: SubscriptionChange()),
                          );
                          //  Get.to(() => SubscriptionChange());
                        },
                        widget: CustomeContainer(
                          radius: 8,
                          vpad: 6,
                          hpad: 5,
                          color: ktertiary,
                          widget: MyText(
                            text: 'Pause',
                            size: 9,
                            color: kwhite,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Bounce_widget(
                        ontap: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                                page: SubscriptionChange(
                              appTitle: 'Cancel Your Subscription',
                              title: 'Cancelation Confirmed!',
                            )),
                          );
                          // Get.to(() => SubscriptionChange(
                          //       appTitle: 'Cancel Your Subscription',
                          //       title: 'Cancelation Confirmed!',
                          //     ));
                        },
                        widget: CustomeContainer(
                          radius: 8,
                          vpad: 6,
                          hpad: 5,
                          color: ktertiary,
                          widget: MyText(
                            text: 'Cancel',
                            size: 9,
                            color: kwhite,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Bounce_widget(
                        ontap: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                                page: SubscriptionChange(
                              appTitle: 'Skip Your Subscription',
                              title: 'Skip Confirmed!',
                            )),
                          );
                          // Get.to(() => SubscriptionChange(
                          //       appTitle: 'Skip Your Subscription',
                          //       title: 'Skip Confirmed!',
                          //     ));
                        },
                        widget: CustomeContainer(
                          radius: 8,
                          vpad: 6,
                          hpad: 5,
                          color: ktertiary,
                          widget: MyText(
                            text: 'Skip',
                            size: 9,
                            color: kwhite,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Bounce_widget(
                    ontap: () {
                      Get.bottomSheet(ChnageDate(), isScrollControlled: true);
                    },
                    widget: CustomeContainer(
                      radius: 8,
                      vpad: 6,
                      hpad: 5,
                      color: ktertiary,
                      widget: MyText(
                        text: 'Change Processing Date',
                        size: 9,
                        color: kwhite,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ProductQuantity(
                    vpad: 0,
                    hpad: 15,
                    dpadh: 10,
                    dpadv: 3,
                    iconSize: 20,
                    radius: 5,
                  )
                ],
              ),
            ],
          ),
        }
      ],
    );
  }
}
