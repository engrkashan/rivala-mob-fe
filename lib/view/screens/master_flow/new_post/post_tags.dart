import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/post_provider.dart';
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

import '../../../../models/product_model.dart';
import '../../../../models/collection_model.dart';
import '../../../../models/squad_model.dart';
import '../../master_store_flow/store_home/product_detailed_description.dart';

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
              // Bounce_widget(
              //     widget: MyText(
              //   text: '+ New',
              //   size: 16,
              //   color: kblue,
              //   weight: FontWeight.w500,
              // )),
              // SizedBox(
              //   width: 12,
              // )
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
                  Consumer<ProductProvider>(
                    builder: (context, ref, _) {
                      final prdList = ref.prds ?? [];

                      if (prdList.isEmpty) {
                        return const Center(child: Text("No products found"));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: prdList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: tags_search_row(
                              product: prdList[index],
                              isProduct: true,
                            ),
                          );
                        },
                      );
                    },
                  )
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadCurrentProducts();
    });
  }
}

class tags_search_row extends StatefulWidget {
  final String? title, tags, image;
  final bool? isSelected,
      hasCheckbox,
      isMainMenu,
      isSquad,
      isCollection,
      onlyTexts,
      isProduct;
  final ProductModel? product;
  final CollectionModel? collection;
  final SquadModel? squad;
  final double? size, hpad;
  final Color? bgColor;
  final Function(dynamic)? onItemSelected;

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
    this.isCollection = false,
    this.onlyTexts = false,
    this.isProduct = false,
    this.product,
    this.collection,
    this.squad,
    this.onItemSelected,
  });

  @override
  State<tags_search_row> createState() => _tags_search_rowState();
}

class _tags_search_rowState extends State<tags_search_row> {
  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    final productProvider = context.watch<ProductProvider>();

    final product = widget.product;

    final isSelected = widget.isSelected ??
        (product != null &&
            (widget.onItemSelected != null
                ? productProvider.selectedMembers.any((p) => p.id == product.id)
                : postProvider.tagProducts.any((p) => p?.id == product.id)));

    // ------------------------------
    // SAFE IMAGE HANDLING
    // ------------------------------
    String? mainImage = widget.image;
    String? title = widget.title;
    String? subtitle = widget.tags;

    if (widget.isProduct == true && product != null) {
      mainImage =
          product.image?.isNotEmpty == true ? product.image!.first : null;
      title = product.title;
      subtitle = product.store?.name;
    } else if (widget.isCollection == true && widget.collection != null) {
      final col = widget.collection!;
      mainImage = (col.products?.isNotEmpty == true &&
              col.products!.first.image?.isNotEmpty == true)
          ? col.products!.first.image!.first
          : null;
      title = col.name;
      subtitle = "${col.products?.length ?? 0} Products";
    } else if (widget.isSquad == true && widget.squad != null) {
      final sq = widget.squad!;
      title = sq.name;
      subtitle = "${sq.members?.length ?? 0} Members";
    }

    return Bounce_widget(
      ontap: () {
        if (widget.onItemSelected != null) {
          if (widget.isProduct == true) widget.onItemSelected!(product);
          if (widget.isCollection == true)
            widget.onItemSelected!(widget.collection);
          if (widget.isSquad == true) widget.onItemSelected!(widget.squad);
          return;
        }

        if (product != null) {
          if (isSelected) {
            postProvider.tagProducts.removeWhere((p) => p?.id == product.id);
          } else {
            postProvider.tagProducts.add(product);
          }
        }
      },
      widget: Container(
        color: isSelected ? widget.bgColor ?? kbackground : ktransparent,
        padding:
            EdgeInsets.symmetric(horizontal: widget.hpad ?? 22, vertical: 2),
        child: Row(
          children: [
            // IMAGE
            widget.isSquad == true
                ? SizedBox(
                    width: 70,
                    child: StackedImagesWidget(size: 25, xShift: 11),
                  )
                : Stack(
                    children: [
                      CommonImageView(
                        url: mainImage,
                        // imagePath: Assets.imagesTagsimg,
                        name: title,
                        width: widget.size ?? 90,
                        height: widget.size ?? 90,
                        radius: 10,
                      ),
                      if (widget.isProduct == true)
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: _TagIcon(),
                        ),
                    ],
                  ),

            const SizedBox(width: 20),

            // TEXT
            Expanded(
              child: widget.isProduct == true && product != null
                  ? InkWell(
                      onTap: () {
                        if (widget.onItemSelected != null) {
                          widget.onItemSelected!(product);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailedDescription(
                                      product: product)));
                        }
                      },
                      child: TwoTextedColumn(
                        text1: title ?? '',
                        text2: subtitle ?? '',
                        size2: 12,
                        color1: kblack,
                        size1: 14,
                        color2: ktertiary,
                      ),
                    )
                  : TwoTextedColumn(
                      text1: title ?? '',
                      text2: subtitle ?? '',
                      size2: 12,
                      color1: kblack,
                      size1: 14,
                      color2: ktertiary,
                    ),
            ),

            // CHECK ICON
            if (widget.onlyTexts != true)
              CustomCheckBox(
                isActive: isSelected,
                onTap: () {},
                borderColor: kblack,
                iscircle: true,
                circleIcon: Icons.check,
              ),
          ],
        ),
      ),
    );
  }
}

class _TagIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      width: 18,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
    );
  }
}
