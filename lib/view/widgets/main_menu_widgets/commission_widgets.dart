import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../models/product_model.dart';

class order_number_detail_container extends StatefulWidget {
  final String? date, amount, savedAmount;
  final int? delay;

  const order_number_detail_container({
    super.key,
    this.date,
    this.amount,
    this.savedAmount,
    this.delay,
  });

  @override
  State<order_number_detail_container> createState() =>
      _order_number_detail_containerState();
}

class _order_number_detail_containerState
    extends State<order_number_detail_container> {
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
                  child: MyText(
                    text: 'Order Number: 125201254',
                    size: 13,
                    weight: FontWeight.w500,
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
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                MyText(
                  text: 'CUSTOMER: ',
                  size: 11,
                  weight: FontWeight.w500,
                ),
                CommonImageView(
                  imagePath: Assets.imagesUser,
                  width: 15,
                  height: 15,
                ),
                MyText(
                  paddingLeft: 10,
                  text: 'Cy Tidwell',
                  size: 11,
                  weight: FontWeight.w400,
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            texts_row(),
            texts_row(
              text1: 'YOU EARNED:',
              text2: '\$600.00',
              color2: kgreen2,
            ),
            texts_row(
              text1: 'DATE:',
              text2: 'Feb. 20, 2025',
            ),
            if (isActive == false) ...{
              SizedBox(
                height: 10,
              ),
              horizontal_img_list()
            },
            if (isActive == true) ...{
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            store_image_stack(
                              height: 55,
                              width: 55,
                              iconSize: 15,
                              showContent: false,
                              showShadow: false,
                              radius: 6,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: 'Blue Floral Short',
                                    size: 12,
                                    weight: FontWeight.w500,
                                    paddingLeft: 8,
                                    color: kblack,
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        text: 'Apollo and Sage',
                                        size: 10,
                                        weight: FontWeight.w500,
                                        paddingLeft: 8,
                                        color: ktertiary,
                                      ),
                                      MyText(
                                        text: '\$50.00',
                                        size: 10,
                                        weight: FontWeight.w500,
                                        paddingLeft: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                            ),
                            CommonImageView(
                              imagePath: Assets.imagesGradline,
                              height: 25,
                            ),
                          ],
                        ),
                        ListView.separated(
                          padding: EdgeInsets.only(top: 0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: order_detail_row());
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                ),
                                CommonImageView(
                                  imagePath: Assets.imagesGradline,
                                  height: 25,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            }
          ],
        ),
      ),
    );
  }
}

class horizontal_img_list extends StatelessWidget {
  final List<ProductModel>? product;
  const horizontal_img_list({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    final totalImages = product?.length ?? 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
            product?.length ?? 0,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: store_image_stack(
                    url: product?[index].image?[0] ?? "",
                    width: 45,
                    height: 45,
                    iconSize: 15,
                    radius: 8,
                    showContent: false,
                    showShadow: false,
                  ),
                )),
        if (totalImages > 0)
          DottedBorder(
            borderType: BorderType.RRect,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            radius: const Radius.circular(8),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: MyText(
                  text: '+ $totalImages more',
                  size: 9,
                  onTap: () {},
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class order_detail_row extends StatelessWidget {
  final String? img, title, desc;
  const order_detail_row({
    super.key,
    this.img,
    this.title,
    this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          store_image_stack(
            height: 30,
            width: 30,
            iconSize: 15,
            showContent: false,
            showIcon: false,
            radius: 50,
            showShadow: false,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: desc ?? 'Purchased from Rio Jan 4th, 2025',
                  size: 10,
                  weight: FontWeight.w500,
                  paddingLeft: 8,
                  color: kblack,
                ),
                Row(
                  children: [
                    MyText(
                      text: title ?? 'Cameron Olds',
                      size: 12,
                      weight: FontWeight.w500,
                      paddingLeft: 8,
                      color: kblack,
                    ),
                    MyText(
                      text: '| 10% (\$75.78)',
                      size: 12,
                      weight: FontWeight.w400,
                      paddingLeft: 2,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class texts_row extends StatelessWidget {
  final Color? color1, color2;
  final String? text1, text2;
  const texts_row({
    super.key,
    this.color1,
    this.color2,
    this.text1,
    this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          MyText(
            text: text1 ?? 'ORDER AMOUNT',
            size: 11,
            weight: FontWeight.w500,
            color: color1 ?? kblack,
          ),
          MyText(
            text: text2 ?? '\$10,050.00',
            size: 11,
            paddingLeft: 3,
            weight: FontWeight.w400,
            color: color2 ?? kblack.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
