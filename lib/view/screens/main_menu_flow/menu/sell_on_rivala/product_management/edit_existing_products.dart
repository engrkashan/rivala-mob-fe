import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/models/promotions_model.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_attribute.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_pdp.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/add_product_collection.dart';
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
  late List<CollectionProvider> col;
  late List<String> images;
  late List<PromotionModel> promos;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CollectionProvider>().loadAllCollections();
    });
  }

  Future<void> _handleCreate() async {
    if (nameCtrl.text.trim().isEmpty ||
        double.tryParse(priceCtrl.text) == null) {
      Get.snackbar("Validation", "Title and valid price required");
      return;
    }

    final provider = context.read<ProductProvider>();

    final product = ProductModel(
      title: nameCtrl.text.trim(),
      description: summaryCtrl.text.trim(),
      price: double.parse(priceCtrl.text),
      SKU: skuCtrl.text.trim(),
      stockQuantity: int.tryParse(stockCtrl.text),
      isActive: true,
      country: "PK",
    );

    await provider.createProduct(product);
    provider.filteredPrds?.add(product);
    if (provider.error == null) {
      Navigator.pop(context);
      Get.snackbar("Success", "Product uploaded");
    } else {
      Get.snackbar("Error", provider.error!);
    }
  }

  Future<void> _handleUpdate() async {
    if (widget.product == null) return;
    final provider = context.read<ProductProvider>();

    // Create updated model
    // Note: Assuming we just update these few fields for now
    final updated = ProductModel(
      id: widget.product!.id,
      title: nameCtrl.text,
      description: summaryCtrl.text,
      price: double.tryParse(priceCtrl.text) ?? widget.product!.price,
      // Keep other fields same...
      image: widget.product!.image,
      store: widget.product!.store,
    );

    await provider.updateProduct(updated);

    if (provider.error == null) {
      Navigator.pop(context);

      Get.snackbar("Success", "Product updated");
    } else {
      Get.snackbar("Error", provider.error!);
    }
  }

  Future<void> _handleDelete() async {
    if (widget.product == null) return;
    final provider = context.read<ProductProvider>();
    await provider.deleteProduct(widget.product!.id!);
    provider.filteredPrds?.remove(widget.product);
    if (provider.error == null) {
      Navigator.pop(context);
      Get.snackbar("Success", "Product deleted");
    } else {
      Get.snackbar("Error", provider.error!);
    }
  }

  String status = "Live";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
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
                    hint: 'Weekly',
                    items: [
                      'Monthly',
                      'Quarterly',
                      'Weekly',
                    ],
                    selectedValue: 'Weekly',
                    onChanged: (e) {}),
                MyTextField(
                  hint: 'Search promos',
                  label: 'Attach a Promo to Subscription',
                  labelSize: 11,
                  readOnly: true,
                  ontapp: () {
                    Get.to(() => StartNewPromo(
                          color: kgreen2,
                          buttonText: 'Save promo',
                        ));
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
                if (widget.hasProducts == true)
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: promo_row());
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
                          builder: (ctx) => Container(
                                padding: EdgeInsets.all(20),
                                height: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Select Collection",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: colProvider.isLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : colProvider.allCollections.isEmpty
                                              ? Center(
                                                  child: Text(
                                                      "No collections found"))
                                              : ListView.builder(
                                                  itemCount: colProvider
                                                      .allCollections.length,
                                                  itemBuilder: (c, i) {
                                                    final col = colProvider
                                                        .allCollections[i];
                                                    return ListTile(
                                                      title: Text(col.name ??
                                                          'Untitled'),
                                                      subtitle: Text(
                                                          col.description ??
                                                              ''),
                                                      onTap: () async {
                                                        if (widget.product !=
                                                            null) {
                                                          Get.back(); // close sheet
                                                          await colProvider
                                                              .addProductToCollection(
                                                                  col.id!,
                                                                  widget
                                                                      .product!
                                                                      .id!);
                                                          if (colProvider
                                                              .error.isEmpty) {
                                                            Get.snackbar(
                                                                "Success",
                                                                "Added to ${col.name}");
                                                          } else {
                                                            Get.snackbar(
                                                                "Error",
                                                                colProvider
                                                                    .error);
                                                          }
                                                        } else {
                                                          Get.back();
                                                          Get.snackbar("Notice",
                                                              "Please save the product first");
                                                        }
                                                      },
                                                    );
                                                  }),
                                    )
                                  ],
                                ),
                              ));
                    },
                  );
                }),
                if (widget.hasProducts == true)
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: promo_row(
                            icon: Assets.imagesCollection2,
                            iconColor: ktertiary,
                          ));
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
                if (widget.hasProducts == true)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              CustomeContainer(
                                color: ktertiary.withOpacity(0.5),
                                width: 55,
                                height: 55,
                                radius: 0,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.close,
                                  color: kwhite,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                MyText(
                  paddingTop: widget.hasProducts == true ? 15 : 0,
                  text: '+ New media',
                  size: 12,
                  weight: FontWeight.w500,
                  color: kblue,
                ),
                SizedBox(
                  height: 23,
                ),
                MyText(
                  text: 'PDP Features & Benefits',
                  size: 15,
                  color: kblack,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                ),
                if (widget.hasProducts == true)
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: promo_row(
                            hasButton: true,
                            icon: Assets.imagesPages,
                            iconColor: ktertiary,
                          ));
                    },
                  ),
                MyText(
                  text: '+ Add new feature',
                  size: 12,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                  color: kblue,
                  onTap: () {
                    Get.bottomSheet(
                        AddPdp(
                          hasCalender: false,
                          buttonText: 'Save Media',
                        ),
                        isScrollControlled: true);
                  },
                ),
                MyText(
                  text: 'Attributes',
                  size: 15,
                  color: kblack,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                ),
                if (widget.hasProducts == true)
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: promo_row(
                            title: 'Color',
                            icon: Assets.imagesAttribute,
                            iconColor: ktertiary,
                          ));
                    },
                  ),
                MyText(
                  text: '+ Add new attribute',
                  size: 12,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                  color: kblue,
                  onTap: () {
                    Get.bottomSheet(AddAttribute(), isScrollControlled: true);
                  },
                ),
                SizedBox(
                    // height: 40,
                    )
              ],
            ),
          ),
          // SizedBox(height: 20),
          Consumer<ProductProvider>(builder: (context, provider, _) {
            return provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      MyButton(
                        buttonText: isEdit ? "Save Changes" : "Upload Product",
                        onTap: isEdit ? _handleUpdate : _handleCreate,
                      ),
                      if (isEdit)
                        MyButton(
                          buttonText: "Delete Product",
                          backgroundColor: Colors.red,
                          onTap: _handleDelete,
                        ),
                      SizedBox(height: 15),
                      SizedBox(height: 30),
                    ],
                  );
          }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
