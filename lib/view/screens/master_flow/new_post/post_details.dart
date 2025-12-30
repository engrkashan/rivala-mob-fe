import 'dart:io';

import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/image_picker_controller.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_location/add_location.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_expiry/post_expiration.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_tags.dart';
import 'package:rivala/view/screens/master_flow/new_post/tag_collection/tag_collection.dart';
import 'package:rivala/view/screens/master_flow/new_post/video_play_screen.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/common_vid_player.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/post_detail_widget.dart';

import '../../../../controllers/providers/post_provider.dart';
import '../../persistent_bottom_nav_bar/persistant_bottom_navbar.dart';

class PostDetails extends StatefulWidget {
  ProductModel? product;
  PostDetails({super.key, this.product});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool isFeaturedPost = false;
  List<Map<String, dynamic>> get postOptions => [
        {
          "icon": Assets.imagesFeatured,
          "title": "Featured Post",
          "ontap": () {
            setState(() {
              isFeaturedPost = !isFeaturedPost;
            });
          },
          'isFeatured': isFeaturedPost

          // 'tags': [""],
        },
        // {
        //   "icon": Assets.imagesPromo,
        //   "title": "Add promo",
        //   'ontap': () {
        //     Get.to(() => StartNewPromo());
        //   },
        //   //  'tags': ["Tech", "Fashion"],
        // },
        {
          "icon": Assets.imagesTags,
          "title": "Tag products",
          'ontap': () {
            Get.to(() => PostTags());
          },
          'tags': Provider.of<PostProvider>(context, listen: false)
              .tagProducts
              .map((e) => e!.title!)
              .toList(),
        },
        {
          "icon": Assets.imagesTagcollection,
          "title": "Tag collections",
          'ontap': () {
            Get.to(() => TagCollection());
          },
          'tags': Provider.of<PostProvider>(context, listen: false)
              .tagCollections
              .map((e) => e?.name ?? "")
              .toList(),
          'tagIcon': Assets.imagesTagcollection
        },
        {
          "icon": Assets.imagesPostexp,
          "title": "Post expiration",
          'ontap': () {
            Get.to(() => PostExpiration());
          },
          'hasText': true,
          'addedText': context.watch<PostProvider>().postExpiration == null
              ? null
              : context.watch<PostProvider>().formattedExpiration(context),
        },
        {
          "icon": Assets.imagesLocation,
          "title": "Add location",
          'ontap': () {
            Get.to(() => AddLocation());
          },
          'hasText': true,
          'addedText': 'Seattle, WA'
        },
      ];

  final titleController = TextEditingController();
  final desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ImagePickerController controller = Get.put(ImagePickerController());
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
            centerTitle: true,
            actions: [
              Bounce_widget(
                  widget: Image.asset(
                Assets.imagesClose,
                width: 18,
                height: 18,
              )),
              SizedBox(
                width: 12,
              )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: ExpandedRow(
                      text1: 'Post details',
                      text2: controller.selectedVideoThumbnail != null
                          ? '1 video'
                          : "$imageCount photos, $videoCount video",
                      size2: 14,
                      color2: kdarkTertiary,
                      size1: 17,
                      weight1: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          // 🟢 First: original selectedMedia loop
                          ...List.generate(
                            controller.selectedMedia.length,
                            (index) {
                              final file = controller.selectedMedia[index];
                              final path = file.path;
                              final ext = path.split('.').last.toLowerCase();
                              final isImage =
                                  ['jpg', 'jpeg', 'png'].contains(ext);

                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: isImage
                                    ? CommonImageView(
                                        width: 90,
                                        height: 90,
                                        radius: 10,
                                        file: file,
                                      )
                                    : SizedBox(
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CommonVideoView(
                                            file: path,
                                            startPlaying: true,
                                            isReel: false,
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),

                          // 🟡 Then: additional thumbnail from controller.selectedVideoData
                          if (controller.selectedVideoThumbnail != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Bounce_widget(
                                ontap: () async {
                                  // Show loading dialog
                                  Get.dialog(
                                    const Center(
                                        child: CircularProgressIndicator(
                                      color: kblack,
                                    )),
                                    barrierDismissible: false,
                                  );

                                  final filteredPath =
                                      await controller.applyVideoFilter(
                                    inputPath: controller
                                        .selectedVideoData['videoFile'].path,
                                    filterName: controller.selectedVideoFilter,
                                  );

                                  // Remove loading
                                  Get.back();

                                  if (filteredPath != null) {
                                    Get.to(() => VideoPlayerScreen(
                                        videoPath: filteredPath));
                                  } else {
                                    Get.snackbar("Error",
                                        "Failed to apply video filter.");
                                  }
                                },
                                widget: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          File(controller
                                              .selectedVideoThumbnail!),
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                        const Center(
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: MyTextField(
                      hint: 'Share what your post is about . . .',
                      label: 'Title',
                      radius: 50,
                      bordercolor: kblack,
                      hintColor: kblack,
                      contentvPad: 10,
                      delay: 200,
                      controller: titleController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: MyTextField(
                      controller: desc,
                      hint: 'Write a caption or share a description . . . ',
                      label: 'Description',
                      radius: 25,
                      delay: 300,
                      maxLines: 4,
                      bordercolor: kblack,
                      hintColor: kblack,
                      contentvPad: 10,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postOptions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            PostDetailOptRow(
                              delay: (index + 1) * 200,
                              icon: postOptions[index]["icon"],
                              hasIcon: index == 0 ? false : true,
                              title: postOptions[index]["title"],
                              ontap: postOptions[index]['ontap'],
                              tags: postOptions[index]['tags'],
                              hasText: postOptions[index]['hasText'],
                              addedText: postOptions[index]['addedText'],
                              isFeatured: postOptions[index]['isFeatured'],
                              tagIcon: postOptions[index]['tagIcon'],
                            ),
                            Divider(
                              color: kblack,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Mybutton2(
              buttonText: 'Share',
              mbot: 30,
              hpad: 22,
              ontap: () async {
                List<String> list = [];
                // final mediaList = controller.selectedMedia;
                // for (final file in mediaList) {
                //   await context.read<MediaProvider>().upload(url: file);
                //   list.add(context.read<MediaProvider>().uploadedUrl!);
                // }
                await context.read<PostProvider>().createPost({
                  "title": titleController.text,
                  "description": desc.text,
                  "media": list,
                  "taggedProducts":
                      Provider.of<PostProvider>(context, listen: false)
                          .tagProducts
                          .map((e) => e?.id)
                          .toList(),
                  "taggedCollection":
                      Provider.of<PostProvider>(context, listen: false)
                          .tagCollections
                          .map((e) => e?.id)
                          .toList(),
                  "locations": null
                });
                final error = context.watch<PostProvider>().error;

                if (error != null && error.isNotEmpty) {
                  AlertInfo.show(context: context, text: error);
                }
                Get.to(() => GradientSuccessScreen(
                      title: 'Congratulations!',
                      textSize: 32,
                      desc: 'Now let’s share your post.',
                      buttontext: 'Share your post!',
                      ontap: () {
                        Get.to(() => PersistentBottomNavBar());
                      },
                      // hasSkip: false,
                    ));
              },
            )
          ],
        ));
  }
}
