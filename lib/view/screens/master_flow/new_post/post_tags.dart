import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/image_stack.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../models/product_model.dart';

class PostTags extends StatefulWidget {
  const PostTags({super.key});

  @override
  State<PostTags> createState() => _PostTagsState();
}

class _PostTagsState extends State<PostTags> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Tag products',
            centerTitle: true,
            actions: [
              Bounce_widget(
                  widget: MyText(
                text: '+ New',
                size: 16,
                color: kblue,
                weight: FontWeight.w500,
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
                    child: MyTextField(
                      radius: 50,
                      filledColor: kgrey4,
                      hint: 'Search products or brands . . .',
                      bordercolor: ktransparent,
                      suffixIcon: Image.asset(
                        Assets.imagesSearch,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, switchIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: tags_search_row(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Mybutton2(
              buttonText2: 'Cancel',
              buttonText: 'Done',
              ontap: () {
                Get.back();
              },
              ontap2: () {
                Get.back();
              },
              mbot: 30,
              hpad: 22,
            )
          ],
        ));
  }
}

class tags_search_row extends StatefulWidget {
  final String? title, tags, image;
  final bool? isSelected,
      hasCheckbox,
      isMainMenu,
      isSquad,
      onlyTexts,
      isProduct;
  final ProductModel? product;
  final double? size, hpad;
  final Color? bgColor;

  const tags_search_row({
    super.key,
    this.title,
    this.tags,
    this.image,
    this.isSelected,
    this.size,
    this.hpad,
    this.bgColor,
    this.hasCheckbox = true,
    this.isMainMenu = false,
    this.isSquad = false,
    this.onlyTexts = false,
    this.isProduct = false,
    this.product,
  });

  @override
  State<tags_search_row> createState() => _tags_search_rowState();
}

class _tags_search_rowState extends State<tags_search_row> {
  late bool isSelected = widget.isSelected ?? false;

  @override
  Widget build(BuildContext context) {
    // ------------------------------
    // IMAGE PRIORITY HANDLING
    // ------------------------------
    final String? productImage = widget.product?.image?.isNotEmpty == true
        ? widget.product!.image!.first
        : null;

    final String? mainImage =
        widget.isProduct == true ? productImage : widget.image;

    return Bounce_widget(
      ontap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      widget: Container(
        color: isSelected ? widget.bgColor ?? kbackground : ktransparent,
        padding:
            EdgeInsets.symmetric(horizontal: widget.hpad ?? 22, vertical: 2),
        child: Row(
          children: [
            // ---------------------------------------------------------
            // IMAGE BLOCK
            // ---------------------------------------------------------
            widget.isSquad == true
                ? SizedBox(
                    width: 70,
                    child: StackedImagesWidget(size: 25, xShift: 11),
                  )
                : Stack(
                    children: [
                      CommonImageView(
                        url: mainImage,
                        imagePath: mainImage ?? Assets.imagesTagsimg,
                        width: widget.size ?? 90,
                        height: widget.size ?? 90,
                        radius: 10,
                      ),

                      // tag icon at bottom right
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kblack.withOpacity(0.1),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: CommonImageView(
                                    imagePath: Assets.imagesTags,
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

            const SizedBox(width: 20),

            // ---------------------------------------------------------
            // TEXT SECTION
            // ---------------------------------------------------------
            Expanded(
              child: widget.isProduct == true
                  ? TwoTextedColumn(
                      text1: widget.product?.title ?? "",
                      text2: widget.product?.store?.name ?? "",
                      size2: 12,
                      color1: kblack,
                      size1: 14,
                      color2: ktertiary,
                    )
                  : widget.isMainMenu == true || widget.isSquad == true
                      ? MyText(
                          text: widget.title ?? '',
                          size: 15,
                          color: kblack,
                          weight: FontWeight.w500,
                        )
                      : TwoTextedColumn(
                          text1: widget.title ?? '',
                          text2: widget.tags ?? '',
                          size2: 12,
                          color1: kblack,
                          size1: 14,
                          color2: ktertiary,
                        ),
            ),

            // ---------------------------------------------------------
            // CHECKBOX OR PLUS ICON
            // ---------------------------------------------------------
            if (widget.onlyTexts == false)
              (widget.hasCheckbox == true)
                  ? CustomCheckBox(
                      isActive: isSelected,
                      onTap: () {},
                      borderColor: kblack,
                      iscircle: true,
                      circleIcon: Icons.check,
                    )
                  : Bounce_widget(
                      ontap: () {
                        setState(() {
                          isSelected = !isSelected;
                        });

                        context
                            .read<ProductProvider>()
                            .toggleMember(widget.product!);
                      },
                      widget: Image.asset(
                        isSelected ||
                                context
                                    .read<ProductProvider>()
                                    .selectedMembers
                                    .contains(widget.product)
                            ? Assets.imagesCheckmark
                            : Assets.imagesAdd,
                        width: 22,
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
