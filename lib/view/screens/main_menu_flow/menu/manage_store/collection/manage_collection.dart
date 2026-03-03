import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/collection_model.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/platform_dialog.dart';

class ManageCollection extends StatefulWidget {
  final CollectionModel collection;
  const ManageCollection({super.key, required this.collection});

  @override
  State<ManageCollection> createState() => _ManageCollectionState();
}

class _ManageCollectionState extends State<ManageCollection> {
  late String collectionId;
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late FocusNode _nameNode;
  late FocusNode _descNode;

  @override
  void initState() {
    super.initState();
    collectionId = widget.collection.id!;

    // Initialize controllers with current values
    _nameController = TextEditingController(text: widget.collection.name);
    _descController =
        TextEditingController(text: widget.collection.description);

    _nameNode = FocusNode();
    _descNode = FocusNode();

    // Add listeners for auto-save on focus loss
    _nameNode.addListener(() {
      if (!_nameNode.hasFocus) {
        _updateCollection(context);
      }
    });

    _descNode.addListener(() {
      if (!_descNode.hasFocus) {
        _updateCollection(context);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _nameNode.dispose();
    _descNode.dispose();
    super.dispose();
  }

  void _updateCollection(BuildContext context) {
    if (_nameController.text.trim().isEmpty) return;

    context.read<CollectionProvider>().updateCollectionDetails(
        collectionId, _nameController.text.trim(), _descController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionProvider>(
      builder: (context, provider, _) {
        final currentCollection = provider.allCollections.firstWhere(
            (c) => c.id == collectionId,
            orElse: () => widget.collection);

        return Scaffold(
          backgroundColor: kwhite,
          appBar: simpleAppBar(
              context: context,
              title:
                  "Manage Collection", // Use static title or listener, but user editing name might be weird if title changes live
              centerTitle: true),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    MyTextField(
                        controller: _nameController,
                        focusNode: _nameNode,
                        label: "Collection Name",
                        bordercolor: ktransparent,
                        filledColor: kgrey2,
                        delay: 150),
                    MyTextField(
                      controller: _descController,
                      focusNode: _descNode,
                      label: 'Collection Description',
                      bordercolor: ktransparent,
                      filledColor: kgrey2,
                      maxLines: 4,
                      delay: 250,
                    ),
                    const SizedBox(height: 15),
                    _buildProductList(context, currentCollection, provider),
                    const SizedBox(height: 80)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductList(BuildContext context, CollectionModel collection,
      CollectionProvider provider) {
    final products = collection.products ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: 'Products',
              size: 15,
              weight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (products.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MyText(
              text: "No products in this collection.",
              size: 12,
              color: Colors.grey,
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: _CollectionProductRow(
                product: products[index],
                collectionId: collection.id!,
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        MyText(
          text: '+ Add product',
          size: 12,
          color: kblue,
          weight: FontWeight.w500,
          onTap: () {
            Get.bottomSheet(
              SearchCriteriaProducts(
                title: 'Add Products',
                hasCheckbox: false, // Immediate selection
                onItemSelected: (item) async {
                  if (item is ProductModel && item.id != null) {
                    Get.back(); // Close sheet
                    await provider.addProductToCollection(
                        collection.id!, item.id!);
                    if (provider.error.isNotEmpty) {
                      AlertInfo.show(
                          context: context, text: "Error: ${provider.error}");
                    } else {
                      AlertInfo.show(
                          context: context, text: "Product added successfully");
                    }
                  }
                },
              ),
              isScrollControlled: true,
            );
          },
        ),
      ],
    );
  }
}

class _CollectionProductRow extends StatelessWidget {
  final ProductModel product;
  final String collectionId;

  const _CollectionProductRow({
    required this.product,
    required this.collectionId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageView(
          url: product.image?.isNotEmpty == true ? product.image!.first : null,
          imagePath: Assets.imagesNutrition2,
          radius: 8,
          height: 44,
          width: 44,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: MyText(
                  text: product.title ?? '',
                  size: 15,
                  weight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  buttonContainer(
                    onTap: () async {
                      final provider = context.read<CollectionProvider>();
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => PlatformConfirmationDialog(
                          title: "Remove Product",
                          message:
                              "Are you sure you want to remove this product from the collection?",
                          confirmText: "Remove",
                          isDestructive: true,
                        ),
                      );

                      if (confirmed == true) {
                        await provider.removeProductFromCollection(
                            collectionId, product.id!);
                        if (provider.error.isNotEmpty) {
                          AlertInfo.show(
                              context: context,
                              text: "Error: ${provider.error}");
                        }
                      }
                    },
                    text: 'Remove',
                    bgColor: kred,
                    radius: 5,
                    vPadding: 6,
                    hPadding: 10,
                    textsize: 11,
                    txtColor: kblack,
                    weight: FontWeight.w500,
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
