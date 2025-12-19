import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/models/store_model.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../../controllers/providers/brands_provider.dart';
import '../../../../controllers/providers/collections_provider.dart';

class StoreMainProfile extends StatefulWidget {
  final String? slug;
  const StoreMainProfile({super.key, this.slug});

  @override
  State<StoreMainProfile> createState() => _StoreMainProfileState();
}

class _StoreMainProfileState extends State<StoreMainProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.slug == null || widget.slug!.isEmpty) {
        context.read<BrandsProvider>().loadCurrentStore();
      } else {
        context.read<BrandsProvider>().loadStoreByHandle(widget.slug!);
        print("Store dtails are: ${widget.slug}");
      }
    });
  }

  @override
  void didUpdateWidget(covariant StoreMainProfile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.slug != widget.slug) {
      final brands = context.read<BrandsProvider>();

      if (widget.slug == null || widget.slug!.isEmpty) {
        brands.loadCurrentStore();
      } else {
        brands.loadStoreByHandle(widget.slug!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Image Stack
            Consumer<BrandsProvider>(
              builder: (context, brands, _) {
                if (brands.currentStore == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return HeaderImageStack(store: brands.currentStore);
              },
            ),

            // Collections List
            Consumer<BrandsProvider>(
              builder: (context, collectionProvider, _) {
                final collections =
                    collectionProvider.currentStore?.collections;
                if (collections == null || collections.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text("No collections found")),
                  );
                }

                return Column(
                  children: collections.map((collection) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: ExpandedRow(
                              text1: collection.name ?? 'Collection',
                              text2: '',
                              color1: kheader,
                              color2: kheader,
                              weight1: FontWeight.w600,
                              size1: 18,
                              size2: 14,
                              useCustomFont: true,
                              ontap2: () {
                                Get.to(() => CollectionGrid());
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          if (collection.description != null)
                            MyText(
                              text: collection.description!,
                              size: 14,
                              color: ksubHeader,
                              paddingBottom: 10,
                              paddingTop: 20,
                              paddingLeft: 22,
                              paddingRight: 22,
                              useCustomFont: true,
                            ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 22),
                            child: Row(
                              children:
                                  (collection.products ?? []).map((product) {
                                final image = (product.image != null &&
                                        product.image!.isNotEmpty)
                                    ? product.image!.first
                                    : null;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: store_image_stack(
                                    url: image, // Pass image url
                                    title: product.title,
                                    price: product.price?.toString(),
                                    onTap: () {
                                      Get.to(() => ProductDetailedDescription(
                                            product: product,
                                          ));
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),

            /// FOOTER
            StoreFotter()
          ],
        ),
      ),
    );
  }
}
