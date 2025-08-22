import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/main.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_product/new_collection.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_product/view_added_product.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/post_detail_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';

class AddProductInstore extends StatefulWidget {
  const AddProductInstore({super.key});

  @override
  State<AddProductInstore> createState() => _AddProductInstoreState();
}

class _AddProductInstoreState extends State<AddProductInstore> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: image_appbar(),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomeContainer(
                  height: 530,
                  color: kwhite,
                  hpad: 0,
                  vpad: 0,
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: ContainerAppbar(
                          title: 'Add product to my storefront',
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                      MyText(
                        text: 'Account',
                        size: 14,
                        color: kheader, //kter
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingBottom: 10,
                         useCustomFont: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            CommonImageView(
                              url: dummyImage2,
                              width: 36,
                              height: 36,
                              radius: 100,
                            ),
                            Expanded(
                              child: MyText(
                                text: 'Jordan Chu',
                                size: 16,
                                color: kheader, //kter
                                weight: FontWeight.w600,
                                paddingLeft: 8,
                                 useCustomFont: true,
                              ),
                            ),
                            MyText(
                              text: 'Change',
                              size: 14,
                              color: kheader, //kter
                              weight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                               useCustomFont: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 18),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                      MyText(
                        text: 'Collection',
                        size: 14,
                        color: kheader, //kter
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingBottom: 10,
                         useCustomFont: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 5,
                              children: [
                                // Limits to 3 max
                                TagsWidget(
                                  tag: 'Apparel',
                                  bgColor: ktransparent,
                                  fontColor: kbody,
                                  tagIcon: Assets.imagesCollection2,
                                   useCustomFont: true,
                                )
                              ],
                            ),
                            MyText(
                              text: '+ New',
                              size: 14,
                              color: kheader, //kter
                              weight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                               useCustomFont: true,
                              onTap: () {
                                Get.to(() => AddProductNewCollection());
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 18),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                      MyText(
                        text: 'Product',
                        size: 14,
                        color: kheader, //kter
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingBottom: 10,
                         useCustomFont: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: store_product_row(),
                      ),
                      Spacer(),
                      CustomeContainer(
                        hasShadow: true,
                        color: kwhite,
                        radius: 50,
                        widget: MyButton(
                          icon: Icons.add,
                          imgColor: kwhite,
                          fontColor: kwhite, //buttoncolor
                          onTap: () {},
                          buttonText: 'Add to store',
                           useCustomFont: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}

class store_product_row extends StatelessWidget {
  const store_product_row({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: () {
        Get.to(() => ViewAddedProduct());
      },
      widget: Row(
        children: [
          Stack(
            children: [
              CommonImageView(
                imagePath: Assets.imagesDummyimage2,
                width: 110,
                height: 120, // Image height
                radius: 15,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Bounce_widget(
                  widget: CommonImageView(
                    imagePath: Assets.imagesApolo2,
                    width: 25,
                    height: 25,
                    radius: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: 'Blue Floral Short',
                    size: 16,
                    color: kheader,
                    weight: FontWeight.w600,
                    maxLines: 2,
                    textOverflow: TextOverflow.visible,
                     useCustomFont: true,
                  ),
                  MyText(
                    text: '\$50.00',
                    size: 14,
                    color: kbody,
                    weight: FontWeight.w400,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                     useCustomFont: true,
                  ),
                  MyText(
                    text: '@apollo.and.sage',
                    size: 14,
                    color: kbody,
                    weight: FontWeight.w400,
                    maxLines: 2,
                    textOverflow: TextOverflow.visible,
                     useCustomFont: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
