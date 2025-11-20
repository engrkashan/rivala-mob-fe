import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/store_model.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_share.dart';
import 'package:rivala/view/screens/master_store_flow/report_iisue.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_product/add_product_instore.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/multiple_product_post_veiw.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/slider_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../models/product_model.dart';

class PostDisplay extends StatefulWidget {
  final bool? isDiscount;
  final VoidCallback? ontap;
  final ProductModel? product;
  const PostDisplay(
      {super.key, this.isDiscount = false, this.ontap, this.product});

  @override
  State<PostDisplay> createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<String> imageList = [
    Assets.imagesDummyimage2,
    Assets.imagesDummyimage2,
    Assets.imagesDummyimage2,
  ];

  @override
  Widget build(BuildContext context) {
    final prd = widget.product;
    return Scaffold(
      body: Stack(
        children: [
          // Background PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: prd?.image?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Get.to(() => ProductDetailedDescription());
                },
                child: CommonImageView(
                  url: prd?.image?[index],
                  width: Get.width,
                  height: Get.height,
                ),
              );
            },
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: prd?.image?.length ?? 0,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white24,
                ),
              ),
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image_appbar(
                  ontap: widget.ontap,
                  store: prd?.store ?? StoreModel(),
                ),
                const Spacer(),
                if (widget.isDiscount == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        buttonContainer(
                          bgColor: kgreen,
                          imagePath: Assets.imagesGift,
                          text: '15% off with code SUNFUN',
                          textsize: 10,
                          imageSize: 11,
                          vPadding: 2,
                          hPadding: 3,
                          useCustomFont: true,
                        ),
                      ],
                    ),
                  ),
                row_widget(
                  title: 'Blue Floral Short',
                  texSize: 18,
                  weight: FontWeight.bold,
                  textColor: kwhite,
                  icon: Assets.imagesPostag,
                  useCustomFont: true,
                  iconSize: 40,
                ),
                const SizedBox(height: 15),
                CustomeContainer(
                  color: kwhite,
                  radius: 50,
                  vpad: 8,
                  hpad: 8,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BottomButtons(
                        icon: Assets.imagesAdd,
                        ontap: () {
                          Get.to(() => AddProductInstore());
                        },
                      ),
                      BottomButtons(
                        icon: Assets.imagesLike,
                        ontap: () {},
                        textt: '113',
                      ),
                      BottomButtons(
                        icon: Assets.imagesComment,
                        ontap: () {},
                        textt: '4',
                      ),
                      BottomButtons(
                        icon: Assets.imagesShare,
                        ontap: () {
                          Get.to(() => PostShare());
                        },
                      ),
                      SimpleExample(
                        trackHeight: 44,
                        callback: () {
                          Get.back();
                          Get.to(() => MultipleProductPostVeiw());
                        },
                        stretchThumb: true,
                        resetCurve: Curves.bounceOut,
                        resetDuration: const Duration(milliseconds: 3000),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class image_appbar extends StatelessWidget {
  final String? title;
  final VoidCallback? ontap;
  final StoreModel? store;
  const image_appbar({
    super.key,
    this.title,
    this.ontap,
    this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageView(
          url: store?.logoUrl ?? '',
          height: 54,
          width: 54,
          radius: 50,
        ),
        Expanded(
          child: MyText(
            text: '@${store?.name}',
            color: kwhite,
            useCustomFont: true,
            size: 16,
            weight: FontWeight.w600,
            paddingLeft: 8,
            shadow: [
              Shadow(
                offset: Offset(5.0, 3.0),
                blurRadius: 5.0,
                color: ktertiary,
              ),
            ],
          ),
        ),
        Bounce_widget(
          ontap: () {
            Get.to(() => ReportIisue());
          },
          widget: Image.asset(
            Assets.imagesCart,
            width: 54,
            height: 54,
          ),
        )
      ],
    );
  }
}

class BottomButtons extends StatelessWidget {
  final String? icon, textt;
  final VoidCallback? ontap;
  const BottomButtons({super.key, this.icon, this.ontap, this.textt});

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
        ontap: ontap,
        widget: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffEDF2F5),
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                icon ?? Assets.imagesAdd,
                height: 16,
                width: 18,
              )),
              if (textt != null)
                MyText(
                  text: textt ?? '113',
                  size: 10,
                  weight: FontWeight.w600,
                )
            ],
          ),
        ));
  }
}
