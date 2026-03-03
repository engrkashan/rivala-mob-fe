import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../models/product_model.dart';

class NewCollection extends StatefulWidget {
  const NewCollection({super.key});

  @override
  State<NewCollection> createState() => _NewCollectionState();
}

class _NewCollectionState extends State<NewCollection> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().selectedMembers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: kwhite),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ContainerAppbar(
            title: 'New Collection',
            textColor: kblack,
            icon: Assets.imagesClose2,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              controller: nameController,
              hint: 'e.g. Summer Collection',
              label: 'Collection Name',
              bordercolor: ktransparent,
              filledColor: kgrey2,
              delay: 150),
          MyTextField(
            controller: descriptionController,
            hint: 'Describe your collection...',
            label: 'Collection Description',
            bordercolor: ktransparent,
            filledColor: kgrey2,
            maxLines: 4,
            delay: 250,
          ),
          MyText(
            text: '+ Add Product to Collection',
            color: kblue,
            weight: FontWeight.w500,
            size: 12,
            paddingTop: 10,
            paddingBottom: 15,
            onTap: () {
              Get.bottomSheet(
                  SearchCriteriaProducts(
                    title: 'Add Products',
                    hasCheckbox: true,
                    onItemSelected: (item) {
                      if (item != null && item is ProductModel) {
                        setState(() {
                          if (products.any((p) => p.id == item.id)) {
                            products.removeWhere((p) => p.id == item.id);
                          } else {
                            products.add(item);
                          }
                        });
                        context.read<ProductProvider>().toggleMember(item);
                      }
                    },
                  ),
                  isScrollControlled: true);
            },
          ),
          if (products.isNotEmpty)
            Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kgrey2,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CommonImageView(
                            url: p.image?.isNotEmpty == true
                                ? p.image!.first
                                : null,
                            width: 70,
                            height: 80,
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                products.removeAt(index);
                              });
                              context.read<ProductProvider>().toggleMember(p);
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: kwhite,
                              child: Icon(Icons.close, size: 12, color: kblack),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          MyButton(
            buttonText: 'Save collection',
            mBottom: 30,
            onTap: () async {
              if (nameController.text.trim().isEmpty) {
                AlertInfo.show(
                    context: context, text: "Wait! enter collection name.");
                return;
              }
              if (products.isEmpty) {
                AlertInfo.show(
                    context: context,
                    text: "ait! select at least one product.");
                return;
              }
              await context.read<CollectionProvider>().setCollection(
                  nameController.text.trim(),
                  descriptionController.text,
                  context,
                  productIds:
                      products.map((e) => e.id).whereType<String>().toList());
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
