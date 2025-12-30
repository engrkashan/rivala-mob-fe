import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/controllers/providers/squads_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/store_model.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_tags.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../controllers/providers/user/seller_provider.dart';
import '../../../../../../models/user_model.dart';

class AddSquadMembers extends StatefulWidget {
  final String? title, hint;
  final bool? isLimit, isProduct, isBrand;
  const AddSquadMembers(
      {super.key,
      this.title,
      this.isLimit = false,
      this.hint,
      this.isProduct = false,
      this.isBrand = false});

  @override
  State<AddSquadMembers> createState() => _AddSquadMembersState();
}

class _AddSquadMembersState extends State<AddSquadMembers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: kwhite),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: widget.title ?? 'Add Member',
                      size: 15,
                      color: kblack,
                      weight: FontWeight.w500,
                    ),
                    if (widget.isLimit == true)
                      row_widget(
                        icon: Assets.imagesAlert2,
                        iconSize: 12,
                        title: 'You’ve reached the max number of members',
                        textColor: kred,
                        texSize: 10,
                        fontstyle: FontStyle.italic,
                      )
                  ],
                ),
              ),
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose2,
                    width: 20,
                  ))
            ],
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            radius: 50,
            contentvPad: 5,
            hint: widget.hint ?? 'Search users',
            prefixIcon: Image.asset(
              Assets.imagesSearch,
              width: 12,
            ),
            onChanged: (text) {
              if (!widget.isProduct! && !widget.isBrand!) {
                context.read<SellerProvider>().searchSellers(text);
              }
              if (widget.isBrand! && !widget.isProduct!) {
                context.read<BrandsProvider>().searchBrands(text);
              }
            },
          ),
          // MEMBERS LIST
          if (!widget.isProduct! && !widget.isBrand!)
            Expanded(
              child: Consumer<SellerProvider>(builder: (context, sellers, _) {
                return ListView.builder(
                  itemCount: sellers.filteredSeller.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: add_members_row(
                        seller: sellers.filteredSeller[index],
                      ),
                    );
                  },
                );
              }),
            ),

// PRODUCTS LIST
          if (widget.isProduct! && !widget.isBrand!)
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, product, _) {
                  final prdList = product.filteredPrds ?? [];
                  if (product.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (prdList.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }

                  return ListView.builder(
                    itemCount: prdList.length,
                    itemBuilder: (context, index) {
                      final prd = prdList[index];

                      final isSelected =
                          product.selectedMembers.any((m) => m.id == prd.id);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            product.toggleMember(
                                prd); // toggles selection & notifies listeners
                          },
                          child: tags_search_row(
                            size: 54,
                            hpad: 0,
                            bgColor: ktransparent,
                            image: (prd.image != null && prd.image!.isNotEmpty)
                                ? prd.image!.first
                                : null,
                            title: prd.title,
                            tags: prd.store?.name,
                            isSelected: isSelected, // pass directly
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          if (widget.isBrand! && !widget.isProduct!)
            Expanded(child: Consumer<BrandsProvider>(
              builder: (context, brands, _) {
                return ListView.builder(
                  itemCount: brands.filteredStores.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: add_members_row(
                        brand: brands.filteredStores[index],
                      ),
                    );
                  },
                );
              },
            )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isProduct! && !widget.isBrand!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SellerProvider>().loadAllUsers();
      });
    }
    if (widget.isBrand! && !widget.isProduct!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<BrandsProvider>().loadAllBrands();
      });
    }
    if (widget.isProduct! && !widget.isBrand!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ProductProvider>().loadCurrentProducts();
      });
    }
  }
}

class add_members_row extends StatefulWidget {
  final UserModel? seller;
  final StoreModel? brand;
  const add_members_row({
    super.key,
    this.seller,
    this.brand,
  });

  @override
  State<add_members_row> createState() => _add_members_rowState();
}

class _add_members_rowState extends State<add_members_row> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final squadMember = context.read<SquadProvider>();
    final brandProvider = context.read<BrandsProvider>();

    // Decide which data to show
    final isBrand = widget.brand != null;
    final image = isBrand
        ? widget.brand!.logoUrl // brand image
        : widget.seller?.avatarUrl; // seller image
    final name = isBrand
        ? widget.brand!.name // brand name
        : widget.seller?.name ?? 'User Name';

    return Row(
      children: [
        CommonImageView(
          url: image,
          imagePath: image ?? Assets.imagesProfileicon,
          width: 54,
          height: 54,
          radius: 100,
        ),
        Expanded(
          child: MyText(
            text: name ?? "",
            size: 15,
            weight: FontWeight.w500,
            paddingLeft: 9,
          ),
        ),
        Bounce_widget(
          ontap: () {
            if (isBrand) {
              brandProvider.toggleBrand(widget.brand!);
            } else {
              squadMember.toggleMember(widget.seller!);
            }
            setState(() {}); // rebuild to update checkmark
          },
          widget: Image.asset(
            // Check provider to see if already selected
            (isBrand
                    ? brandProvider.selectedBrands
                        .any((b) => b.id == widget.brand!.id)
                    : squadMember.selectedMembers
                        .any((m) => m.id == widget.seller!.id))
                ? Assets.imagesCheckmark
                : Assets.imagesAdd,
            width: 22,
          ),
        )
      ],
    );
  }
}
