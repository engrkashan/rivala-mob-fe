import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../../controllers/providers/brands_provider.dart';
import '../../../../controllers/providers/follow_provider.dart';
import '../../../../models/store_model.dart';
import '../../../../models/product_model.dart';

class StoreMainProfile extends StatefulWidget {
  final String? slug;

  const StoreMainProfile({
    super.key,
    this.slug,
  });
  @override
  State<StoreMainProfile> createState() => _StoreMainProfileState();
}

class _StoreMainProfileState extends State<StoreMainProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final brands = context.read<BrandsProvider>();

      if (widget.slug != null && widget.slug!.isNotEmpty) {
        brands.loadStoreByHandle(widget.slug!);
      } else {
        brands.loadCurrentStore();
      }

      // Load follow status list for the user
      context.read<FollowProvider>().loadFollowings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final brands = context.watch<BrandsProvider>();
    final store = widget.slug != null
        ? brands.visitedStore
        : brands.currentStore;

    final followProvider = context.watch<FollowProvider>();
    final bool isFollowed = store?.id != null ? followProvider.isFollowed(store!.id!) : false;

    // Group products by category
    final Map<String, List<ProductModel>> productsByCategory = {};
    if (store?.products != null) {
      for (var product in store!.products) {
        final catName = product.productCategory?.name ?? product.category ?? "Uncategorized";
        if (!productsByCategory.containsKey(catName)) {
          productsByCategory[catName] = [];
        }
        productsByCategory[catName]!.add(product);
      }
    }

    return Scaffold(
      backgroundColor: kwhite,
      body: store == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Header Image Stack
                SliverToBoxAdapter(
                  child: HeaderImageStack(store: store),
                ),

                // Action Buttons Bar (Follow, Share, Copy Link)
                SliverToBoxAdapter(
                  child: _buildActionButtons(context, store, isFollowed),
                ),

                // Grouped Categories / Products List
                if (productsByCategory.isEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 22),
                      child: Center(
                        child: Text(
                          "No products found",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final entry = productsByCategory.entries.elementAt(index);
                        final categoryName = entry.key;
                        final categoryProducts = entry.value;

                        final title = categoryName == "new_arrival"
                            ? (store.name ?? "") + " New Arrival"
                            : categoryName == "Uncategorized"
                                ? "More Products"
                                : categoryName;

                        final description = categoryName == "new_arrival"
                            ? "Discover our vibrant, eco-friendly collection, curated for you."
                            : "Explore our collection of $categoryName.";

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 22),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.between,
                                  children: [
                                    Expanded(
                                      child: MyText(
                                        text: title,
                                        size: 18,
                                        color: kheader,
                                        weight: FontWeight.bold,
                                        useCustomFont: true,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => CollectionGrid(
                                              store: store,
                                              text1: title,
                                              text2: description,
                                            ));
                                      },
                                      child: MyText(
                                        text: 'View All',
                                        size: 14,
                                        color: ksubHeader,
                                        weight: FontWeight.w500,
                                        useCustomFont: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 22),
                                child: MyText(
                                  text: description,
                                  size: 13,
                                  color: ksubHeader.withOpacity(0.8),
                                  useCustomFont: true,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 22),
                                child: Row(
                                  children: categoryProducts.map((product) {
                                    final image = (product.image != null &&
                                            product.image!.isNotEmpty)
                                        ? product.image!.first
                                        : null;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: store_image_stack(
                                        url: image,
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
                      },
                      childCount: productsByCategory.length,
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),

                // Apollo & Sage Custom Brand Banner
                SliverToBoxAdapter(
                  child: _buildApoloAndSageBanner(context, store),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),

                /// FOOTER
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: StoreFotter(store: store),
                )
              ],
            ),
    );
  }

  // Action Buttons Row (Follow/Unfollow, Share Profile, Copy Link)
  Widget _buildActionButtons(BuildContext context, StoreModel store, bool isFollowed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      child: Row(
        children: [
          // Follow / Unfollow Button
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () async {
                if (store.id == null) return;
                final followProvider = context.read<FollowProvider>();
                if (isFollowed) {
                  await followProvider.unfollowBrand(store.id!);
                } else {
                  await followProvider.followBrand(store.id!);
                }
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isFollowed ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isFollowed ? Colors.black.withOpacity(0.2) : Colors.black,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    isFollowed ? 'Unfollow' : 'Follow',
                    style: TextStyle(
                      color: isFollowed ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Share Profile Button
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () {
                final String storeUrl = 'https://rivala.com/store/${store.slug ?? store.id}';
                Share.share('Check out this premium store on Rivala: ${store.name}\n$storeUrl');
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Share Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Copy Link Button
          InkWell(
            onTap: () {
              final String storeUrl = 'https://rivala.com/store/${store.slug ?? store.id}';
              Clipboard.setData(ClipboardData(text: storeUrl));
              Get.snackbar(
                'Link Copied',
                'Store link copied to clipboard!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black.withOpacity(0.8),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                margin: const EdgeInsets.all(15),
                borderRadius: 10,
              );
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E8DB8), Color(0xFF52C08C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.link,
                    color: Color(0xFF2E8DB8),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Apollo & Sage Brand Banner
  Widget _buildApoloAndSageBanner(BuildContext context, StoreModel store) {
    final heroImageUrl = store.hero?.heroImageUrl;
    final String name = store.name ?? "Apollo & Sage";
    final String bio = store.hero?.bodyText ?? store.owner?.bio ?? 
        "Designed and created for the outdoor lovers who are searching for sunshine filled coastlines, beachfront cafés and crystal blue waves.";

    return Container(
      color: const Color(0xFFF4F4F4),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF809185),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 60,
            height: 3,
            color: const Color(0xFF809185),
          ),
          const SizedBox(height: 15),
          Text(
            bio,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: heroImageUrl != null && heroImageUrl.isNotEmpty
                  ? CommonImageView(
                      url: heroImageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: const Color(0xFFD3D3D3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.image,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "No image uploaded yet",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
