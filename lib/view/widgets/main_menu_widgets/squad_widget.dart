import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/main.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import 'package:provider/provider.dart';
import 'package:rivala/controllers/providers/squads_provider.dart';
import 'package:rivala/view/widgets/platform_dialog.dart';
import '../../../models/product_model.dart';
import '../../../models/store_model.dart';
import '../../../models/user_model.dart';
import '../../screens/main_menu_flow/menu/connections/squads/add_squad_members.dart';

class squad_members_container extends StatefulWidget {
  final String? commission;
  final int? delay;
  final List<UserModel>? members;
  final String? squadId;

  const squad_members_container({
    super.key,
    this.delay,
    this.commission,
    this.members,
    this.squadId,
  });

  @override
  State<squad_members_container> createState() =>
      _squad_members_containerState();
}

class _squad_members_containerState extends State<squad_members_container> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100))],
      child: CustomeContainer(
        color: kwhite,
        hpad: 10,
        hasShadow: true,
        radius: 15,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: 'Members',
              size: 15,
              weight: FontWeight.w500,
            ),
            MyText(
              text: 'Total Commission: 100%',
              size: 12,
              weight: FontWeight.w400,
            ),
            MyText(
              text: 'Commissions do not equal 100%',
              size: 12,
              color: kred,
              weight: FontWeight.w400,
              paddingBottom: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.members?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: squad_members_row(
                    squadId: widget.squadId,
                    userId: widget.members?[index].id,
                    owner: index == 0 ? true : false,
                    admin: index == 2 ? true : false,
                    title: widget.members?[index].name,
                    img: widget.members?[index].avatarUrl,
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            MyText(
              text: '+ Invite Member',
              size: 12,
              color: kblue,
              weight: FontWeight.w500,
              onTap: () {
                Get.bottomSheet(
                  AddSquadMembers(
                    isLimit: true,
                    isProduct: false,
                    isBrand: false,
                  ),
                  isScrollControlled: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class squad_members_row extends StatelessWidget {
  final bool? owner, admin;
  final String? title, img, squadId, userId;

  const squad_members_row(
      {super.key,
      this.owner,
      this.admin,
      this.title,
      this.img,
      this.squadId,
      this.userId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageView(
          url: img,
          name: title,
          width: 30,
          height: 30,
          radius: 100,
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              row_widget(
                title: title ?? 'Austin Larsen',
                texSize: 15,
                icon: Assets.imagesCrown,
                isIconRight: true,
                iconSize: 12,
              ),
              Row(
                children: [
                  if (owner == false)
                    Bounce_widget(
                      ontap: () async {
                        if (squadId == null || userId == null) return;
                        final provider = context.read<SquadProvider>();
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => PlatformConfirmationDialog(
                            title: "Remove Member",
                            message:
                                "Are you sure you want to delete this user?",
                            confirmText: "Delete",
                            isDestructive: true,
                          ),
                        );

                        if (confirmed == true) {
                          final squad = provider.singleSquad;
                          if (squad != null) {
                            squad.members?.removeWhere((m) => m.id == userId);
                            await provider.updateSquad(squadId!, squad);
                          }
                        }
                      },
                      widget: buttonContainer(
                        text: 'Remove Member',
                        bgColor: kred,
                        radius: 5,
                        vPadding: 4,
                        textsize: 10,
                        hPadding: 3,
                        txtColor: kblack,
                        weight: FontWeight.normal,
                      ),
                    ),
                  if (owner == false && admin == true) SizedBox(width: 3),
                  if (owner == false && admin == true)
                    buttonContainer(
                      text: 'Make Admin',
                      bgColor: ktertiary,
                      radius: 5,
                      vPadding: 4,
                      hPadding: 3,
                      textsize: 10,
                      txtColor: kblack,
                      weight: FontWeight.normal,
                    ),
                ],
              ),
              if (owner == true) MyText(text: 'Owner', size: 11),
            ],
          ),
        ),
        // add_itemss(),
      ],
    );
  }
}

////squad sellers

class squad_seller extends StatefulWidget {
  final String? commission;
  final int? delay;
  final bool? isProduct;
  final List<StoreModel>? store;
  final List<ProductModel>? products;
  final String? squadId;
  const squad_seller({
    super.key,
    this.delay,
    this.commission,
    this.isProduct = false,
    this.store,
    this.products,
    this.squadId,
  });

  @override
  State<squad_seller> createState() => _squad_sellerState();
}

class _squad_sellerState extends State<squad_seller> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100))],
      child: CustomeContainer(
        color: kwhite,
        hpad: 10,
        hasShadow: true,
        radius: 15,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isProduct == false)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: 'Sellers',
                    size: 15,
                    weight: FontWeight.w500,
                  ),
                  Bounce_widget(
                      ontap: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                      widget: Icon(isActive == true
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_right_rounded))
                ],
              ),
            MyText(
              text:
                  'Members of the squad will not receive a commission for any products sold by a seller in this list.',
              size: 11,
              fontStyle: FontStyle.italic,
              weight: FontWeight.w400,
              paddingBottom: 15,
            ),
            if (widget.isProduct == false)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.store?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: squad_seller_row(
                        squadId: widget.squadId,
                        store: widget.store?[index],
                      ));
                },
              ),
            if (widget.isProduct == true)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.products?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: squad_seller_row(
                          squadId: widget.squadId,
                          product: widget.products?[index]));
                },
              ),
            SizedBox(
              height: 15,
            ),
            MyText(
              text: widget.isProduct == true ? '+ Add product' : '+ Add Brand',
              size: 12,
              color: kblue,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

//squad seller row
class squad_seller_row extends StatelessWidget {
  final StoreModel? store;
  final ProductModel? product;
  final String? squadId;
  const squad_seller_row({super.key, this.store, this.product, this.squadId});

  @override
  Widget build(BuildContext context) {
    final bool isProduct = product != null;
    return Row(
      children: [
        CommonImageView(
          url: isProduct ? product?.image?.first : store?.logoUrl,
          // imagePath: isProduct
          //     ? Assets.imagesNutrition2 // fallback if product has no image
          //     : store?.logoUrl ?? Assets.imagesNutrition2,
          name: isProduct ? product?.title : store?.name,
          radius: 8,
          height: 44,
          width: 44,
        ),
        SizedBox(width: 8),
        Expanded(
          // Ensures column takes available space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: MyText(
                  text:
                      isProduct ? (product?.title ?? '') : (store?.name ?? ''),
                  size: 15,
                  weight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Bounce_widget(
                    ontap: () async {
                      if (squadId == null) return;
                      final provider = context.read<SquadProvider>();
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => PlatformConfirmationDialog(
                          title: isProduct ? "Remove Product" : "Remove Seller",
                          message: isProduct
                              ? "Are you sure you want to delete this product?"
                              : "Are you sure you want to delete this user?",
                          confirmText: "Delete",
                          isDestructive: true,
                        ),
                      );

                      if (confirmed == true) {
                        final squad = provider.singleSquad;
                        if (squad != null) {
                          if (isProduct) {
                            squad.products
                                ?.removeWhere((p) => p.id == product?.id);
                          } else {
                            squad.sellers
                                ?.removeWhere((s) => s.id == store?.id);
                          }
                          await provider.updateSquad(squadId!, squad);
                        }
                      }
                    },
                    widget: buttonContainer(
                      text: isProduct ? 'Remove Product' : 'Remove Seller',
                      bgColor: kred,
                      radius: 5,
                      vPadding: 6,
                      hPadding: 10,
                      textsize: 11,
                      txtColor: kblack,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Divider(color: kgrey2),
            ],
          ),
        ),
      ],
    );
  }
}
