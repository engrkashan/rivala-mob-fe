import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class StoreMainProfile extends StatefulWidget {
  const StoreMainProfile({super.key});

  @override
  State<StoreMainProfile> createState() => _StoreMainProfileState();
}

class _StoreMainProfileState extends State<StoreMainProfile> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  double _progress1 = 0.0;
  double _progress2 = 0.0;
  double _progress3 = 0.0;

  int _currentIndex1 = 0;
  int _currentIndex2 = 0;
  int _currentIndex3 = 0;

  final int _totalItems = 5; // Total number of images

  @override
  void initState() {
    super.initState();
    _scrollController1
        .addListener(() => _updateProgress(_scrollController1, 1));
    _scrollController2
        .addListener(() => _updateProgress(_scrollController2, 2));
    _scrollController3
        .addListener(() => _updateProgress(_scrollController3, 3));
  }

  void _updateProgress(ScrollController controller, int index) {
    if (controller.hasClients) {
      final double maxScroll = controller.position.maxScrollExtent;
      final double currentScroll = controller.position.pixels;
      final double itemWidth = Get.width * 0.7; // Approximate width per image
      final int newIndex = (currentScroll / itemWidth).round();

      setState(() {
        if (index == 1 && newIndex != _currentIndex1) {
          _currentIndex1 = newIndex;
          _progress1 = (_currentIndex1 / (_totalItems - 1)).clamp(0.0, 1.0);
        } else if (index == 2 && newIndex != _currentIndex2) {
          _currentIndex2 = newIndex;
          _progress2 = (_currentIndex2 / (_totalItems - 1)).clamp(0.0, 1.0);
        } else if (index == 3 && newIndex != _currentIndex3) {
          _currentIndex3 = newIndex;
          _progress3 = (_currentIndex3 / (_totalItems - 1)).clamp(0.0, 1.0);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController1
        .removeListener(() => _updateProgress(_scrollController1, 1));
    _scrollController2
        .removeListener(() => _updateProgress(_scrollController2, 2));
    _scrollController3
        .removeListener(() => _updateProgress(_scrollController3, 3));

    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //hedaer image stack
              HeaderImageStack(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: ExpandedRow(
                        text1: 'New Arrivals',
                        text2: 'View All',
                        color1: kheader,
                        color2: kheader,
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
                      color: ksubHeader,
                      paddingBottom: 10,
                      paddingTop: 20,
                      paddingLeft: 22,
                      paddingRight: 22,
                      useCustomFont: true,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController1,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_totalItems, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Column(
                              children: [
                                store_image_stack(),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: horizontal_slider(progress: _progress1),
                    )
                  ],
                ),
              ),

              //NEW SECTION

              Container(
                color: Color(0xffF4F4F4),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                child: Column(
                  children: [
                    MyText(
                      text: 'This is Apollo and Sage',
                      color: kheader,
                      size: 25,
                      weight: FontWeight.w600,
                      paddingBottom: 18,
                      useCustomFont: true,
                    ),
                    Container(
                      color: kheader,
                      width: 30,
                      height: 2,
                    ),
                    MyText(
                      paddingTop: 18,
                      text:
                          'APOLLO, greek god of the sun.\n\nSAGE, the abbreviation of Sagittarius, known for free-spirited and adventurous women.\n\nTogether, they are searching for sunshine filled coastlines, beachfront cafés and crystal blue waves.',
                      color: kbody,
                      size: 14,
                      weight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      useCustomFont: true,
                    ),
                  ],
                ),
              ),

//NEW SECTION
              CommonImageView(
                imagePath: Assets.imagesDummy4,
                width: Get.width,
                height: 400,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: ExpandedRow(
                        text1: 'Weekend Warrior Squad',
                        text2: 'View All',
                        color1: kheader,
                        color2: kbody,
                        weight1: FontWeight.w600,
                        size1: 18,
                        size2: 14,
                        useCustomFont: true,
                      ),
                    ),
                    MyText(
                      text:
                          "Explore our exclusive men's collection, blending contemporary style with Australia's coastal spirit.",
                      size: 14,
                      color: ksubHeader,
                      paddingBottom: 10,
                      paddingTop: 20,
                      paddingLeft: 22,
                      paddingRight: 22,
                      useCustomFont: true,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController2,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: store_image_stack(),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: horizontal_slider(progress: _progress2),
                    )
                  ],
                ),
              ),

              ///SECTION
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: ExpandedRow(
                        text1: 'Weekend Warriors',
                        text2: 'View All',
                        color1: kheader,
                        color2: kbody,
                        weight1: FontWeight.w600,
                        size1: 18,
                        size2: 14,
                        useCustomFont: true,
                      ),
                    ),
                    MyText(
                      text:
                          "Our women's collection, where elegance meets Australia's vibrant beach culture in every design.",
                      size: 14,
                      color: ksubHeader,
                      paddingBottom: 10,
                      paddingTop: 20,
                      paddingLeft: 22,
                      paddingRight: 22,
                      useCustomFont: true,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController3,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: store_image_stack(),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: horizontal_slider(progress: _progress3),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///FOTTER
              StoreFotter()
            ],
          ),
        ));
  }
}
