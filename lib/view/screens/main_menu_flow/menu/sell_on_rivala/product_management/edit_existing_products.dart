import 'dart:io';

import 'package:alert_info/alert_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/controllers/providers/promo_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/controllers/providers/media_provider.dart';
import 'package:rivala/models/collection_model.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/promotions_model.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_attribute.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_product_collection.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_promo.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/start_new_promo.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/product_desc_widgets.dart';

class EditExistingProducts extends StatefulWidget {
  final bool? hasProducts;
  final ProductModel? product; // Add product model

  const EditExistingProducts(
      {super.key, this.hasProducts = true, this.product});

  @override
  State<EditExistingProducts> createState() => _EditExistingProductsState();
}

class _EditExistingProductsState extends State<EditExistingProducts> {
  bool get isEdit => widget.product != null;
  late TextEditingController nameCtrl;
  late TextEditingController summaryCtrl;
  late TextEditingController
      priceCtrl; // reusing commission field for price/commission
  late TextEditingController skuCtrl;
  late TextEditingController stockCtrl;
  late List<String> images;
  List<PromotionModel> selectedPromos = [];
  List<CollectionModel> selectedCollections = [];
  List<Map<String, dynamic>> productAttributes = [];

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.product?.title ?? '');
    summaryCtrl =
        TextEditingController(text: widget.product?.description ?? '');
    priceCtrl =
        TextEditingController(text: widget.product?.price?.toString() ?? '');
    skuCtrl = TextEditingController(text: widget.product?.SKU ?? '');
    stockCtrl = TextEditingController(
        text: widget.product?.stockQuantity?.toString() ?? '');

    images = widget.product?.image ?? [];
    selectedPromos = List.from(widget.product?.promotions ?? []);
    selectedCollections = List.from(widget.product?.collections ?? []);
    if (widget.product != null) {
      status = widget.product!.isActive == true ? "Live" : "Off";
    }

    // Reconstitute productAttributes from sizes/colors
    if (widget.product?.sizes != null && widget.product!.sizes!.isNotEmpty) {
      productAttributes.add({
        'name': 'Sizes',
        'variants':
            widget.product!.sizes!.map((s) => {'attribute': s}).toList(),
      });
    }
    if (widget.product?.colors != null && widget.product!.colors!.isNotEmpty) {
      productAttributes.add({
        'name': 'Colors',
        'variants':
            widget.product!.colors!.map((c) => {'attribute': c}).toList(),
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CollectionProvider>().loadAllCollections();
      await context.read<PromoProvider>().setPromos();
    });
  }

  Future<void> _handleCreate() async {
    if (nameCtrl.text.trim().isEmpty) {
      AlertInfo.show(context: context, text: "Product name is required");
      return;
    }
    if (double.tryParse(priceCtrl.text) == null) {
      AlertInfo.show(context: context, text: "Valid price is required");
      return;
    }
    if (summaryCtrl.text.trim().isEmpty) {
      AlertInfo.show(context: context, text: "Product summary is required");
      return;
    }

    final provider = context.read<ProductProvider>();
    final mediaProvider = context.read<MediaProvider>();
    final collectionProvider = context.read<CollectionProvider>();
    final promoProvider = context.read<PromoProvider>();

    provider.setLoading(true);

    try {
      List<String> finalImageUrls = [];

      for (String item in images) {
        if (item.startsWith('http')) {
          finalImageUrls.add(item);
        } else {
          try {
            File file = File(item);
            await mediaProvider.upload(url: file);
            if (mediaProvider.uploadedUrl != null) {
              finalImageUrls.add(mediaProvider.uploadedUrl!);
            }
          } catch (e) {
            debugPrint("Failed to upload image $item: $e");
          }
        }
      }

      List<String> sizes = [];
      List<String> colors = [];
      for (var attr in productAttributes) {
        String name = attr['name']?.toString().toLowerCase() ?? '';
        List variants = attr['variants'] as List? ?? [];
        if (name.contains('size')) {
          sizes.addAll(variants
              .map((v) => v['attribute']?.toString() ?? '')
              .where((s) => s.isNotEmpty));
        } else if (name.contains('color')) {
          colors.addAll(variants
              .map((v) => v['attribute']?.toString() ?? '')
              .where((s) => s.isNotEmpty));
        }
      }

      final product = ProductModel(
        title: nameCtrl.text.trim(),
        description: summaryCtrl.text.trim(),
        price: double.parse(priceCtrl.text),
        SKU: skuCtrl.text.trim(),
        stockQuantity: int.tryParse(stockCtrl.text),
        isActive: true,
        country: "PK",
        image: finalImageUrls,
        sizes: sizes,
        colors: colors,
        promotions: selectedPromos,
        collections: selectedCollections,
      );

      final createdProduct = await provider.createProduct(product);

      if (provider.error != null) {
        AlertInfo.show(context: context, text: provider.error!);
      } else if (createdProduct != null) {
        // --- Sync with Collections ---
        for (var col in selectedCollections) {
          if (col.id != null) {
            await collectionProvider.addProductToCollection(
                col.id!, createdProduct.id!);
          }
        }

        // --- Sync with Promotions ---
        for (var promo in selectedPromos) {
          if (promo.id != null) {
            await promoProvider.addProductToPromo(
                promo.id!, createdProduct.id!);
          }
        }

        if (mounted) {
          AlertInfo.show(
              context: context, text: "Product created successfully");
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        AlertInfo.show(context: context, text: e.toString());
      }
    } finally {
      if (mounted) {
        provider.setLoading(false);
      }
    }
  }

  Future<void> _handleUpdate() async {
    if (widget.product == null) return;
    if (nameCtrl.text.trim().isEmpty) {
      AlertInfo.show(context: context, text: "Product name is required");
      return;
    }

    final provider = context.read<ProductProvider>();
    final mediaProvider = context.read<MediaProvider>();
    final collectionProvider = context.read<CollectionProvider>();
    final promoProvider = context.read<PromoProvider>();

    provider.setLoading(true);

    try {
      List<String> finalImageUrls = [];

      for (String item in images) {
        if (item.startsWith('http')) {
          finalImageUrls.add(item);
        } else {
          try {
            File file = File(item);
            await mediaProvider.upload(url: file);
            if (mediaProvider.uploadedUrl != null) {
              finalImageUrls.add(mediaProvider.uploadedUrl!);
            }
          } catch (e) {
            debugPrint("Failed to upload image $item: $e");
          }
        }
      }

      List<String> sizes = [];
      List<String> colors = [];
      for (var attr in productAttributes) {
        String name = attr['name']?.toString().toLowerCase() ?? '';
        List variants = attr['variants'] as List? ?? [];
        if (name.contains('size')) {
          sizes.addAll(variants
              .map((v) => v['attribute']?.toString() ?? '')
              .where((s) => s.isNotEmpty));
        } else if (name.contains('color')) {
          colors.addAll(variants
              .map((v) => v['attribute']?.toString() ?? '')
              .where((s) => s.isNotEmpty));
        }
      }

      final updated = ProductModel(
        id: widget.product!.id,
        title: nameCtrl.text.trim(),
        description: summaryCtrl.text.trim(),
        price: double.tryParse(priceCtrl.text) ?? widget.product!.price,
        SKU: skuCtrl.text.trim(),
        stockQuantity:
            int.tryParse(stockCtrl.text) ?? widget.product!.stockQuantity,
        isActive: widget.product!.isActive,
        country: widget.product!.country ?? "PK",
        image: finalImageUrls,
        store: widget.product!.store,
        sizes: sizes,
        colors: colors,
        promotions: selectedPromos,
        collections: selectedCollections,
      );

      await provider.updateProduct(updated);

      if (provider.error == null) {
        // --- Sync with Collections ---
        for (var col in selectedCollections) {
          if (col.id != null) {
            await collectionProvider.addProductToCollection(
                col.id!, widget.product!.id!);
          }
        }

        // --- Sync with Promotions ---
        for (var promo in selectedPromos) {
          if (promo.id != null) {
            await promoProvider.addProductToPromo(
                promo.id!, widget.product!.id!);
          }
        }

        if (mounted) {
          AlertInfo.show(
              context: context, text: "Product updated successfully");
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          AlertInfo.show(context: context, text: provider.error!);
        }
      }
    } catch (e) {
      if (mounted) {
        AlertInfo.show(context: context, text: e.toString());
      }
    } finally {
      if (mounted) {
        provider.setLoading(false);
      }
    }
  }

  Future<void> _handleDelete() async {
    if (widget.product == null) return;
    final provider = context.read<ProductProvider>();
    await provider.deleteProduct(widget.product!.id!);
    provider.filteredPrds?.remove(widget.product);
    if (provider.error == null) {
      if (mounted) {
        AlertInfo.show(context: context, text: "Product deleted successfully");
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        AlertInfo.show(context: context, text: provider.error!);
      }
    }
  }

  String status = "Live";
  String availableForSubs = "Weekly";
  bool subscriptionEnabled = true;

  Future<void> _pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );

    if (result != null) {
      setState(() {
        images.addAll(result.paths.whereType<String>());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: kwhite,
          appBar: simpleAppBar(
              context: context,
              title: widget.product?.title ?? 'Edit Product',
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
                    // square_image_stack(
                    //     url: widget.product?.image?.first), // Pass image
                    SizedBox(
                      height: 40,
                    ),
                    MyTextField(
                      controller: nameCtrl,
                      hint: 'Name',
                      label: 'Name',
                      suffixIcon: Image.asset(
                        Assets.imagesEdit,
                        width: 20,
                        height: 20,
                      ),
                      delay: 200,
                      filledColor: kblack.withOpacity(0.05),
                      bordercolor: ktransparent,
                    ),
                    MyTextField(
                      hint: 'Physical Good',
                      label: 'Product Type',
                      suffixIcon: Image.asset(
                        Assets.imagesEdit,
                        width: 20,
                        height: 20,
                      ),
                      delay: 350,
                      filledColor: kblack.withOpacity(0.05),
                      bordercolor: ktransparent,
                    ),
                    MyTextField(
                      controller: summaryCtrl,
                      hint: 'Product Summary',
                      label: 'Summary',
                      suffixIcon: Image.asset(
                        Assets.imagesEdit,
                        width: 20,
                        height: 20,
                      ),
                      delay: 500,
                      maxLines: 4,
                      filledColor: kblack.withOpacity(0.05),
                      bordercolor: ktransparent,
                    ),
                    MyTextField(
                      hint: 'Any Special Notes',
                      label: 'Special Notes',
                      suffixIcon: Image.asset(
                        Assets.imagesEdit,
                        width: 20,
                        height: 20,
                      ),
                      delay: 650,
                      maxLines: 4,
                      filledColor: kblack.withOpacity(0.05),
                      bordercolor: ktransparent,
                    ),
                    CustomDropDown(
                        delay: 800,
                        label: 'Status',
                        hint: 'Live',
                        items: [
                          'Off',
                          'Paused',
                          'Live',
                        ],
                        selectedValue: status,
                        onChanged: (e) {
                          status = e;
                          setState(() {});
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextField(
                            controller: priceCtrl,
                            hint: '20%',
                            label: 'Price', // Changed from Commission
                            suffixIcon: Image.asset(
                              Assets.imagesEdit,
                              width: 20,
                              height: 20,
                            ),
                            marginBottom: 0,
                            delay: 950,
                            filledColor: kblack.withOpacity(0.05),
                            bordercolor: ktransparent,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: ProductQuantity(
                            initialValue: widget.product?.stockQuantity,
                            onChanged: (val) {
                              stockCtrl.text = val.toString();
                            },
                            radius: 5,
                            vpad: 2,
                            hpad: 2,
                            dpadh: 10,
                            midDistance: 3,
                            dpadv: 5,
                          ),
                        )
                      ],
                    ),
                    MyTextField(
                      controller: skuCtrl,
                      hint: '1234564',
                      label: 'SKU',
                      suffixIcon: Image.asset(
                        Assets.imagesEdit,
                        width: 20,
                        height: 20,
                      ),
                      delay: 1000,
                      maxLines: 4,
                      filledColor: kblack.withOpacity(0.05),
                      bordercolor: ktransparent,
                    ),
                    CustomDropDown(
                        delay: 1250,
                        label: 'Available for Subscription',
                        hasSwitch: true,
                        switchValue: subscriptionEnabled,
                        onSwitchChanged: (val) {
                          setState(() {
                            subscriptionEnabled = val;
                          });
                        },
                        hint: 'Weekly',
                        items: [
                          'Monthly',
                          'Quarterly',
                          'Weekly',
                        ],
                        selectedValue: availableForSubs,
                        onChanged: (e) {
                          availableForSubs = e;
                          setState(() {});
                        }),
                    MyTextField(
                      hint: 'Search promos',
                      label: 'Attach a Promo to Subscription',
                      labelSize: 11,
                      readOnly: true,
                      ontapp: () async {
                        final List<PromotionModel>? results =
                            await Get.bottomSheet(
                          AddPromo(
                            isSelectable: true,
                            alreadySelected: selectedPromos,
                          ),
                          isScrollControlled: true,
                        );

                        if (results != null) {
                          setState(() {
                            selectedPromos = results;
                          });
                        }
                      },
                      prefixIcon: Image.asset(
                        Assets.imagesSearch,
                        width: 11,
                        height: 11,
                      ),
                      hintSize: 11,
                      delay: 1000,
                      contentvPad: 5,
                      bordercolor: ktertiary,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedPromos.length,
                      itemBuilder: (context, index) {
                        final promo = selectedPromos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: kblue.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: kblue.withOpacity(0.2)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.abc_outlined, // Fallback icon
                                    color: kblue,
                                    size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: MyText(
                                    text: promo.title ?? "Untitled Promo",
                                    size: 14,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.close,
                                      size: 18, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      selectedPromos.removeAt(index);
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    MyText(
                      text: '+ New promo',
                      size: 12,
                      weight: FontWeight.w500,
                      paddingBottom: 15,
                      color: kblue,
                    ),
                    Consumer<CollectionProvider>(
                        builder: (context, colProvider, _) {
                      return MyTextField(
                        label: 'Add to Collection',
                        hint: 'Search collections',
                        prefixIcon: Image.asset(
                          Assets.imagesSearch,
                          width: 11,
                          height: 11,
                        ),
                        hintSize: 11,
                        delay: 1000,
                        contentvPad: 5,
                        bordercolor: ktertiary,
                        readOnly: true,
                        ontapp: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (ctx) => StatefulBuilder(
                                    builder: (context, setSheetState) =>
                                        Container(
                                      padding: EdgeInsets.all(20),
                                      height: 500,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Select Collection",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Done"),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Expanded(
                                            child: colProvider.isLoading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : colProvider
                                                        .allCollections.isEmpty
                                                    ? Center(
                                                        child: Text(
                                                            "No collections found"))
                                                    : ListView.builder(
                                                        itemCount: colProvider
                                                            .allCollections
                                                            .length,
                                                        itemBuilder: (c, i) {
                                                          final col = colProvider
                                                              .allCollections[i];
                                                          final isSelected =
                                                              selectedCollections
                                                                  .any((element) =>
                                                                      element
                                                                          .id ==
                                                                      col.id);
                                                          return ListTile(
                                                            title: Text(
                                                                col.name ??
                                                                    'Untitled'),
                                                            trailing: isSelected
                                                                ? Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color:
                                                                        kgreen2)
                                                                : Icon(Icons
                                                                    .radio_button_unchecked),
                                                            onTap: () {
                                                              setState(() {
                                                                if (isSelected) {
                                                                  selectedCollections
                                                                      .removeWhere((item) =>
                                                                          item.id ==
                                                                          col.id);
                                                                } else {
                                                                  selectedCollections
                                                                      .add(col);
                                                                }
                                                              });
                                                              setSheetState(
                                                                  () {});
                                                            },
                                                          );
                                                        }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                      );
                    }),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedCollections.length,
                      itemBuilder: (context, index) {
                        final col = selectedCollections[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: kgreen2.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: kgreen2.withOpacity(0.2)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.collections_bookmark_outlined,
                                    color: kgreen2, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: MyText(
                                    text: col.name ?? "Untitled Collection",
                                    size: 14,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.close,
                                      size: 18, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      selectedCollections.removeAt(index);
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    MyText(
                      text: '+ New collection',
                      size: 12,
                      weight: FontWeight.w500,
                      color: kblue,
                      onTap: () {
                        Get.bottomSheet(AddProductCollection(),
                            isScrollControlled: true);
                      },
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    MyText(
                        text: 'Media',
                        size: 15,
                        weight: FontWeight.w500,
                        paddingBottom: 15,
                        color: kblack),
                    if (images.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(images.length, (index) {
                            final image = images[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  CustomeContainer(
                                    width: 90,
                                    height: 80,
                                    radius: 8,
                                    vpad: 0,
                                    hpad: 0,
                                    widget: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: image.startsWith('http')
                                          ? Image.network(
                                              image,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(image),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            kblack.withOpacity(0.5),
                                        child: Icon(
                                          Icons.close,
                                          color: kwhite,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    MyText(
                      paddingTop: images.isNotEmpty ? 15 : 0,
                      text: '+ New media',
                      size: 12,
                      weight: FontWeight.w500,
                      color: kblue,
                      onTap: _pickMedia,
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    // MyText(
                    //   text: 'PDP Features & Benefits',
                    //   size: 15,
                    //   color: kblack,
                    //   weight: FontWeight.w500,
                    //   paddingBottom: 15,
                    // ),
                    // if (widget.hasProducts == true)
                    //   ListView.builder(
                    //     padding: EdgeInsets.all(0),
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: 4,
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //           padding: const EdgeInsets.only(bottom: 15),
                    //           child: promo_row(
                    //             hasButton: true,
                    //             icon: Assets.imagesPages,
                    //             iconColor: ktertiary,
                    //           ));
                    //     },
                    //   ),
                    // MyText(
                    //   text: '+ Add new feature',
                    //   size: 12,
                    //   weight: FontWeight.w500,
                    //   paddingBottom: 15,
                    //   color: kblue,
                    //   onTap: () {
                    //     Get.bottomSheet(
                    //         AddPdp(
                    //           hasCalender: false,
                    //           buttonText: 'Save Media',
                    //         ),
                    //         isScrollControlled: true);
                    //   },
                    // ),
                    MyText(
                      text: 'Attributes',
                      size: 15,
                      color: kblack,
                      weight: FontWeight.w500,
                      paddingBottom: 15,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productAttributes.length,
                      itemBuilder: (context, index) {
                        final attr = productAttributes[index];
                        final variantsList = attr['variants'] as List;
                        final variantNames = variantsList
                            .map((v) => v['attribute'])
                            .where((v) => v != null && v.toString().isNotEmpty)
                            .join(", ");

                        return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: InkWell(
                              onTap: () async {
                                final result = await Get.bottomSheet(
                                  AddAttribute(initialData: attr),
                                  isScrollControlled: true,
                                );
                                if (result != null) {
                                  setState(() {
                                    productAttributes[index] = result;
                                  });
                                }
                              },
                              child: promo_row(
                                title: "${attr['name']}: $variantNames",
                                icon: Assets.imagesAttribute,
                                iconColor: ktertiary,
                              ),
                            ));
                      },
                    ),
                    MyText(
                      text: '+ Add new attribute',
                      size: 12,
                      weight: FontWeight.w500,
                      paddingBottom: 15,
                      color: kblue,
                      onTap: () async {
                        final result = await Get.bottomSheet(AddAttribute(),
                            isScrollControlled: true);
                        if (result != null) {
                          setState(() {
                            productAttributes.add(result);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    Consumer<ProductProvider>(builder: (context, provider, _) {
                      return provider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                MyButton(
                                  buttonText: isEdit
                                      ? "Save Changes"
                                      : "Upload Product",
                                  onTap: isEdit ? _handleUpdate : _handleCreate,
                                ),
                                if (isEdit)
                                  MyButton(
                                    buttonText: "Delete Product",
                                    backgroundColor: Colors.red,
                                    onTap: _handleDelete,
                                  ),
                                const SizedBox(height: 30),
                              ],
                            );
                    }),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ), // Column
        ), // Scaffold

        if (provider.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: ksecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
