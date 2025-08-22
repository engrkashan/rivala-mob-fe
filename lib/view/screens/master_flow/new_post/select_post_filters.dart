import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_filter/css_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/controllers/image_picker_controller.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/main.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_details.dart';
import 'package:rivala/view/screens/master_flow/new_post/video_play_screen.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class SelectPostFilters extends StatefulWidget {
  final String? count;
  bool isVideo;
  SelectPostFilters({super.key, required this.isVideo, this.count});

  @override
  _SelectPostFiltersState createState() => _SelectPostFiltersState();
}

class _SelectPostFiltersState extends State<SelectPostFilters> {
  final ImagePickerController controller = Get.put(ImagePickerController());

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // Controller for horizontal image scrolling
  final PageController _pageController = PageController(viewportFraction: 0.5);

  // Store applied filters for each image
  List<Widget> _selectedFilters = [];

  @override
  void initState() {
    super.initState();
    // Initialize selected filters with original images
    _selectedFilters = List.generate(
      widget.isVideo ? 1 : controller.selectedImages.length,
      (index) => CSSFilterPresets.origin(
        child: Stack(
          children: [
            widget.isVideo
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      CommonImageView(
                        file: File(controller.selectedVideoData['thumbnail']),
                        fit: BoxFit.cover,
                        radius: 10,
                        height: Get.height,
                      ),
                      Icon(
                        Icons.play_circle,
                        size: 28,
                        color: kred,
                      ),
                    ],
                  )
                : CommonImageView(
                    file: controller.selectedImages[index],
                    fit: BoxFit.cover,
                    radius: 10,
                    height: Get.height,
                  ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    buttonContainer(
                      vPadding: 3,
                      hPadding: 12,
                      iconColor: kwhite,
                      bgColor: kblack2.withOpacity(0.5),
                      text: 'Edit',
                      useCustomFont: true,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  int _currentIndex = 0; // Track current page index

  @override
  Widget build(BuildContext context) {
        final allMedia = controller.selectedMedia;
    final imageCount = allMedia.where((file) {
  final ext = file.path.split('.').last.toLowerCase();
  return ['jpg', 'jpeg', 'png'].contains(ext);
}).length;

final videoCount = allMedia.where((file) {
  final ext = file.path.split('.').last.toLowerCase();
  return ['mp4', 'mov', 'avi'].contains(ext);
}).length;
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: 'New post',
        contentColor: kblack,
        centerTitle: true,
        actions: [
          Bounce_widget(
            widget: Image.asset(
              Assets.imagesClose,
              width: 18,
              height: 18,
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(color: kgrey2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: ExpandedRow(
              text1: 'Edit media',
              text2:
              widget.count??   "$imageCount photos, $videoCount video",

              size2: 14,
              color2: kdarkTertiary,
              size1: 17,
              weight1: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: CarouselSlider.builder(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: Get.height,
                  aspectRatio: 1 / 2,
                  enlargeFactor: 0.2,
                  viewportFraction: 0.8,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemCount:
                    widget.isVideo ? 1 : controller.selectedImages.length,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _selectedFilters[index],
                  );
                }),
          ),
          // Swipeable Image Section
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: PageView.builder(
          //         padEnds: false,
          //         controller: _pageController,
          //         itemCount: imageUrls.length,
          //         onPageChanged: (index) {
          //           setState(() {
          //             _currentIndex = index;
          //           });
          //         },
          //         itemBuilder: (context, index) {
          //           return Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 8),
          //             child: _selectedFilters[index],
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),

          MyText(
            paddingTop: 10,
            text: 'Filters',
            size: 16,
            paddingLeft: 20,
            weight: FontWeight.w500,
          ),

          // Filter selection for the current image
          Container(
            height: 155,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 20),
                _buildFilterOption(
                    'Normal',
                    CSSFilterPresets.origin(
                        child: CommonImageView(
                      file: widget.isVideo
                          ? File(controller.selectedVideoData['thumbnail'])
                          : File(controller.selectedImages[_currentIndex].path),
                      fit: BoxFit.cover,
                      radius: 10,
                    )),
                    CommonImageView(
                      file: widget.isVideo
                          ? File(controller.selectedVideoData['thumbnail'])
                          : File(controller.selectedImages[_currentIndex].path),
                      fit: BoxFit.cover,
                      radius: 10,
                    )),
                _buildFilterOption(
                  'Clarendon',
                  CSSFilterPresets.ins1977(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                  CSSFilterPresets.ins1977(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                ),
                _buildFilterOption(
                  'Gingham',
                  CSSFilterPresets.ins1977V2(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                  CSSFilterPresets.ins1977V2(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                ),
                _buildFilterOption(
                  'Aden',
                  CSSFilterPresets.insAden(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                  CSSFilterPresets.insAden(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                ),
                _buildFilterOption(
                  'Amaro',
                  CSSFilterPresets.insAmaro(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                  CSSFilterPresets.insAmaro(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                ),
                _buildFilterOption(
                  'Ashby',
                  CSSFilterPresets.insAshby(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                  CSSFilterPresets.insAshby(
                      child: CommonImageView(
                    file: widget.isVideo
                        ? File(controller.selectedVideoData['thumbnail'])
                        : File(controller.selectedImages[_currentIndex].path),
                    fit: BoxFit.cover,
                    radius: 10,
                  )),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ksecondary,
                      ),
                    ),
                  )
                : Mybutton2(
                    buttonText: 'Next',
                    ontap: () async {
                      if (widget.isVideo) {
                        controller.isLoading.value = true;
                        final filteredPath = await controller.applyVideoFilter(
                          inputPath:
                              controller.selectedVideoData['videoFile'].path,
                          filterName: controller.selectedVideoFilter,
                        );
                        controller.isLoading.value = false;
                        if (filteredPath != null) {
                          // Navigate to VideoPlayerScreen with filtered video path
                       Get.to(() => PostDetails());
                        } else {
                          Get.snackbar(
                              "Error", "Failed to apply video filter.");
                        }
                      } else {
                        // Handle image post flow
                        Get.to(() => PostDetails());
                      }
                    },
                  ),
          )

          //SizedBox(height: 120),
        ],
      ),
    );
  }

  // Method to build filter options
  Widget _buildFilterOption(String label, Widget filter, Widget filterPreview) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: () {
        setState(() {
          _selectedFilters[_currentIndex] =
              filter; // Apply filter to the current image
          controller.selectedVideoFilter =
              label.toLowerCase(); // ✅ Save filter name string
        });
      },
      child: Animate(
        effects: [ShimmerEffect()],
        child: Container(
          margin: const EdgeInsets.only(right: 9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 94,
                  height: 100,
                  child: filterPreview, // Preview of the filter
                ),
              ),
              SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: _selectedFilters[_currentIndex] == filter
                      ? kblack
                      : ktertiary,
                  fontFamily: AppFonts.poppins,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
