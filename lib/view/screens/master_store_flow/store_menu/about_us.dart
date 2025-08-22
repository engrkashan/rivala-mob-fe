import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0.0;
  int _currentIndex = 0;
  final int _totalItems = 5;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (_scrollController.hasClients) {
      final double itemWidth = Get.width * 0.7; // Approximate width per image
      final int newIndex =
          (_scrollController.position.pixels / itemWidth).round();

      setState(() {
        _currentIndex = newIndex;
        _progress = (_currentIndex / (_totalItems - 1)).clamp(0.0, 1.0);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateProgress);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kheader,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Bounce_widget(
                            ontap: () {
                                 Navigator.pop(context);
                            },
                            widget: Image.asset(
                              Assets.imagesBackicon1,
                              width: 20,
                              height: 20,
                              color: kwhite,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Image.asset(Assets.imagesStorelogo,
                              height: 95,
                              width: 240,
                              fit: BoxFit.contain,
                              color: kwhite),
                        ),
                      ],
                    ),
                  ),
                  CommonImageView(
                    radius: 15,
                    imagePath: Assets.imagesDummyimage2,
                    height: 250,
                    width: Get.width,
                  ),
                  MyText(
                    text: 'This is\nApollo & Sage',
                    color: kwhite,
                    size: 35,
                    paddingTop: 15,
                    paddingBottom: 15,
                    useCustomFont: true,
                    textAlign: TextAlign.center,
                  ),
                  MyText(
                    text: 'Aussie vibes for every beach.',
                    color: kwhite,
                    size: 25,
                    weight: FontWeight.bold,
                    paddingBottom: 15,
                    useCustomFont: true,
                    textAlign: TextAlign.center,
                    paddingLeft: 18,
                    paddingRight: 18,
                  ),
                  MyText(
                    text:
                        'APOLLO, greek god of the sun.SAGE, the abbreviation of Sagittarius, known for free-spirited and adventurous women.Together, they are searching for sunshine filled coastlines, beachfront cafés and crystal blue waves.',
                    color: kwhite,
                    size: 16,
                    weight: FontWeight.normal,
                    paddingBottom: 35,
                    useCustomFont: true,
                    textAlign: TextAlign.center,
                    paddingLeft: 18,
                    paddingRight: 18,
                  ),
                  MyButton(
                    backgroundColor: kwhite,
                    fontColor: kblack,
                    useCustomFont: true,
                    mhoriz: 18,
                    buttonText: 'SHOP OUR LOOKS',
                    mBottom: 40,
                  )
                ],
              ),
            ),

            ////section2
            Container(
              color: kwhite,
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  MyText(
                    text: 'From the beginning...',
                    color: kheader,
                    size: 25,
                    weight: FontWeight.bold,
                    paddingBottom: 20,
                    useCustomFont: true,
                    textAlign: TextAlign.center,
                    paddingLeft: 18,
                    paddingRight: 18,
                  ),
                  MyText(
                    text:
                        'Since 2021 we have been working on sample after sample, fabric after fabric and restock after restock... and we are so proud of the final product that we get to share with you.\nApollo & Sage is truly our passion project and a way in which we can connect to our ocean loving selves. We thank you for your love and support and hope you love your A&S pieces as much as we do!',
                    color: kheader,
                    size: 16,
                    weight: FontWeight.w400,
                    paddingBottom: 20,
                    useCustomFont: true,
                    textAlign: TextAlign.center,
                    paddingLeft: 18,
                    paddingRight: 18,
                  ),
                  MyText(
                    text: '- Morgan Rose Moroney and Steve Cook',
                    color: kheader,
                    size: 16,
                    weight: FontWeight.bold,
                    paddingBottom: 50,
                    useCustomFont: true,
                    textAlign: TextAlign.center,
                    paddingLeft: 20,
                    paddingRight: 20,
                  ),
                  Stack(
                    children: [
                      CommonImageView(
                        imagePath: Assets.imagesDummy4,
                        width: Get.width,
                        height: 299,
                      ),
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200.withOpacity(0.5),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///sesction 3

            Container(
              color: kheader,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: ExpandedRow(
                      text1: 'Our Original Designs',
                      text2: 'View All',
                      color1: kwhite,
                      color2: kwhite,
                      weight1: FontWeight.w600,
                      size1: 18,
                      size2: 14,
                      useCustomFont: true,
                      ontap2: () {
                        Get.to(() => CollectionGrid());
                      },
                    ),
                  ),
                  MyText(
                    text:
                        'Discover our vibrant, eco-friendly swimwear collection, inspired by Bondi Beach. ',
                    size: 14,
                    color: kwhite,
                    paddingBottom: 10,
                    paddingTop: 20,
                    paddingLeft: 22,
                    paddingRight: 22,
                    useCustomFont: true,
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_totalItems, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: store_image_stack(),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: horizontal_slider(
                      progress: _progress,
                      color: kwhite.withOpacity(0.5),
                      pColor: kwhite,
                    ),
                  ),
                ],
              ),
            ),

            ///section4

            Container(
              color: kwhite,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  buy_get_image(),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: MyText(
                      text: 'First time here?',
                      color: kheader,
                      size: 25,
                      weight: FontWeight.w600,
                      paddingTop: 15,
                      useCustomFont: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: MyText(
                      text:
                          'Welcome! We want to hook you up right. So use “SWIMAUSSIE” at checkout to get a free suit on us. Spread the Apollo & Sage love.  ',
                      color: kheader,
                      size: 16,
                      weight: FontWeight.w400,
                      paddingTop: 15,
                      paddingBottom: 30,
                      paddingLeft: 18,
                      paddingRight: 18,
                      useCustomFont: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MyButton(
                    backgroundColor: kdargrey,
                    fontColor: kwhite,
                    useCustomFont: true,
                    mhoriz: 18,
                    buttonText: 'SHOP OUR LOOKS',
                    mBottom: 40,
                  )
                ],
              ),
            ),
            StoreFotter()
          ],
        ),
      ),
    );
  }
}

class buy_get_image extends StatelessWidget {
  const buy_get_image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CommonImageView(
            imagePath: Assets.imagesDummy5,
            height: 300,
            width: 380,
            radius: 15,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: MyText(
                text: 'Buy 1, Get 1 Free!',
                color: kbody,
                size: 25,
                weight: FontWeight.w600,
                paddingTop: 15,
                useCustomFont: true,
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: MyText(
                text: 'Discount code: SWIMAUSSIE',
                color: kbody,
                size: 14,
                weight: FontWeight.normal,
                paddingBottom: 15,
                useCustomFont: true,
                textAlign: TextAlign.center,
                paddingLeft: 18,
                paddingRight: 18,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          right: 30,
          child: CommonImageView(
            imagePath: Assets.imagesApolo,
            width: 40,
            height: 40,
            radius: 100,
          ),
        ),
      ],
    );
  }
}
