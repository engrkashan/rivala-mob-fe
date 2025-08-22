import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';

import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';

import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/slider_button.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/product_desc_widgets.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailedDescription extends StatefulWidget {
  const ProductDetailedDescription({super.key});

  @override
  State<ProductDetailedDescription> createState() =>
      _ProductDetailedDescriptionState();
}

class _ProductDetailedDescriptionState
    extends State<ProductDetailedDescription> {
  final PageController _pageController = PageController();
  final List<String> imageList = List.filled(6, Assets.imagesDummyimage2);
  final List<Color> colorList = [
    Color(0xff2F3B52),
    Color(0xffD2C9E6),
    Color(0xffEBCDB1),
    Color(0xffC2D1D9),
    Color(0xff3C3C3C),
  ];
  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];

  String? selectedSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
            backgroundColor: ktransparent,
            body: ImageLayoutWidget(
              bodyWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ContainerAppbar(title: 'Shop Name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: kgrey2),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SizedBox(
                        height: 350,
                        width: Get.width,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: imageList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CommonImageView(
                                  imagePath: imageList[index],
                                  width: Get.width,
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: imageList.length,
                      effect: JumpingDotEffect(
                        activeDotColor: kheader,
                        dotColor: kgrey2,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        buttonContainer(
                          bgColor: ktransparent,
                          imagePath: Assets.imagesGift,
                          text: '15% off with code SUNFUN',
                          txtColor: kgreen,
                          iconColor: kgreen,
                          textsize: 10,
                          imageSize: 11,
                          vPadding: 2,
                          hPadding: 3,
                           useCustomFont: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TwoTextedColumn(
                      text1: 'Blue Floral Short',
                      text2: '\$50',
                      size1: 20,
                      size2: 20,
                      color1: kbody, //kheader,
                      color2: kbody,
                      weight1: FontWeight.w600,
                       useCustomFont: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MyText(
                    text: 'Select Color',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w500,
                    paddingLeft: 18,
                    paddingBottom: 8,
                     useCustomFont: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: colorList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: color_picker(
                              bgColor: colorList[index],
                              size: 44,
                              showShadow: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //size seltc
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ExpandedRow(
                      text1: 'Select Size',
                      text2: 'Size Guide',
                      color2: kblue,
                      size1: 14,
                      size2: 14,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      color1: kheader,
                      decoration2: TextDecoration.underline,
                       useCustomFont: true,
                    ),
                  ),
                  //size guideee
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: sizes.map((size) {
                        bool isSelected = selectedSize == size;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: buttonContainer(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            borderColor: isSelected ? kblack : kgrey2,
                            bgColor:
                                isSelected ? kblack : kgrey3.withOpacity(0.5),
                            radius: 8,
                            hPadding: 12,
                            vPadding: 5,
                            text: size,
                            txtColor: isSelected ? kwhite : kblack,
                            textsize: 16,
                             useCustomFont: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  //
                  MyText(
                    text: 'Purchase Options',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                     useCustomFont: true,
                  ),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: PurchaseOptsWidget(
                        title: 'One-Time Purchase',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: PurchaseOptsWidget(
                        hasDropdown: true,
                      )),
                  /////qunatty
                  MyText(
                    text: 'Quantity',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    paddingTop: 20,
                     useCustomFont: true,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ProductQuantity()),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CustomAccordion(
                        title: 'Menu ${index + 1}',
                      );
                    },
                  ),
                  /////other opts
                  MyText(
                    text: 'You might also like',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    paddingTop: 20,
                     useCustomFont: true,
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: store_image_stack(
                            quickbut: true,
                          ),
                        );
                      }),
                    ),
                  ),

                  /////customer reviews
                  MyText(
                    text: 'Customer Reviews',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    paddingTop: 20,
                     useCustomFont: true,
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: store_image_stack(
                            showContent: false,
                            showIcon: false,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomeContainer(
                      radius: 15,
                      vpad: 8,
                      hpad: 8,
                      borderColor: kgrey2,
                      widget: Row(
                        children: [
                          Image.asset(
                            Assets.imagesStore2,
                            width: 44,
                            height: 44,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TwoTextedColumn(
                              text1: 'More items in the store',
                              text2: '@Lululemon',
                              size1: 14,
                              size2: 16,
                              weight1: FontWeight.w500,
                              weight2: FontWeight.w600,
                              color1: kheader,
                              color2: kblue,
                               useCustomFont: true,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: kblack,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: CustomeContainer(
                      hasShadow: true,
                      color: kwhite,
                      radius: 50,
                      vpad: 8,
                      mbott: 0,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BottomButtons(
                            icon: Assets.imagesBack2,
                          ),
                          SimpleExample(
                            trackHeight: 40,
                            callback: () {
                              Get.to(() => ProductCheckout());
                            },
                            stretchThumb: true,
                            resetCurve: Curves.bounceOut,
                            resetDuration: const Duration(milliseconds: 3000),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //const SizedBox(height: 20),
                ],
              ),
            )),
      ],
    );
  }
}
