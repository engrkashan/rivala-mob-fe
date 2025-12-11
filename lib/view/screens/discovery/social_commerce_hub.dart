import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/discovery/search_discovery_products.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/curated_brands.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/providers/product_provider.dart';
import '../../../controllers/providers/post_provider.dart';

class SocialCommerceHub extends StatefulWidget {
  const SocialCommerceHub({super.key});

  @override
  State<SocialCommerceHub> createState() => _SocialCommerceHubState();
}

class _SocialCommerceHubState extends State<SocialCommerceHub> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _loadedFeeds = {};

  final Map<String, GlobalKey> _feedKeys = {
    "high-earning": GlobalKey(),
    "back-to-school": GlobalKey(),
    "trending": GlobalKey(),
    "for-you": GlobalKey(),
    "local-product": GlobalKey(),
  };

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<BrandsProvider>().loadRecentBrands();
      if (!mounted) return;
      final prd = context.read<ProductProvider>();
      _loadFeed("recent", prd);

      final pp = context.read<PostProvider>();
      pp.loadCreators();
      pp.loadDiscoverPosts();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      for (var entry in _feedKeys.entries) {
        _tryLoadFeed(entry.key, entry.value);
      }
    });
  }

  void _tryLoadFeed(String feedKey, GlobalKey key) {
    if (_loadedFeeds.contains(feedKey)) return;

    final context = key.currentContext;
    if (context == null) return;

    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final position = box.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;

    // Trigger when section is near viewport
    if (position < screenHeight * 1.3) {
      _loadedFeeds.add(feedKey);
      final prd = context.read<ProductProvider>();
      prd.loadFeed(feedKey);
      debugPrint("Lazy loaded: $feedKey");
    }
  }

  void _loadFeed(String key, ProductProvider prd) {
    if (_loadedFeeds.contains(key)) return;
    _loadedFeeds.add(key);
    prd.loadFeed(key);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildHorizontalBrandList() {
    return Consumer<BrandsProvider>(
      builder: (context, brands, _) {
        final recent = brands.store;

        if (recent == null) {
          // Data is not loaded yet, show a loader or empty container
          return SizedBox(
            height: 150, // adjust based on your widget size
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (recent.isEmpty) {
          // No brands available
          return SizedBox(
            height: 150,
            child: Center(child: Text("No brands available")),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 22),
          child: Row(
            children: recent.map((brand) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  // onTap: () => Get.to(() => ProductDetailedDescription()),
                  child: curated_brand_widget(
                    size: 135,
                    networkImg:
                        brand.logoUrl ?? '', // fallback if logoUrl is null
                    title: brand.name ?? '', // fallback if name is null
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildProductSection({
    required String feedKey,
    required String title,
    String? iconAsset,
    GlobalKey? key,
  }) {
    final isLoaded = _loadedFeeds.contains(feedKey);

    return Container(
      key: key ?? GlobalKey(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: row_widget(
              title: title,
              texSize: 20,
              weight: FontWeight.bold,
              icon: iconAsset,
              isIconRight: true,
            ),
          ),
          SizedBox(
            height: 180,
            child: Consumer<ProductProvider>(
              builder: (context, prd, _) {
                final products = prd.productsFor(feedKey) ?? [];

                if (products.isEmpty) {
                  return _SkeletonProductRow();
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(left: 22),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, index) {
                    final p = products[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => ProductDetailedDescription(
                            product: p,
                          )),
                      child: curated_brand_widget(
                        size: 135,
                        radius: 20,
                        fit: BoxFit.cover,
                        networkImg: (p.image?.isNotEmpty ?? false)
                            ? p.image!.first
                            : null,
                        title: p.title ?? "Product",
                        desc: "@${p.owner?.username ?? 'user'}",
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _SkeletonProductRow() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 22),
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, __) => Container(
          width: 135,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child:
                  Image.asset(Assets.imagesRivalalogo, height: 33, width: 148),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: MyTextField(
                hint: 'Search products',
                bordercolor: kgrey2,
                filledColor: ktransparent,
                contentvPad: 6.5,
                radius: 45,
                prefixIcon: Image.asset(Assets.imagesSearch, width: 15),
                readOnly: true,
                ontapp: () {
                  Navigator.of(context).push(
                      CustomPageRoute(page: const SearchDiscoveryProducts()));
                },
              ),
            ),

            // Recent Brands
            MyText(
              text: 'Recent Brands',
              size: 20,
              weight: FontWeight.bold,
              color: kblack2,
              paddingLeft: 22,
              paddingBottom: 10,
            ),
            _buildHorizontalBrandList(),

            // Recent Products
            Consumer<ProductProvider>(
              builder: (context, prd, _) {
                final products = prd.productsFor("recent") ?? [];
                if (products.isEmpty) return const SizedBox.shrink();
                return _buildProductSection(
                  feedKey: "recent",
                  title: "Recent Products",
                );
              },
            ),

            // Recent Creators
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: MyText(
                text: 'Recent Creators',
                size: 20,
                weight: FontWeight.bold,
                color: kblack2,
                paddingLeft: 22,
              ),
            ),
            Consumer<PostProvider>(
              builder: (context, postProvider, _) {
                final creators = postProvider.creators ?? [];
                if (creators.isEmpty) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  ); // Or shimmer
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 22),
                  child: Row(
                    children: creators.map((user) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: curated_brand_widget(
                          size: 135,
                          radius: 100,
                          fit: BoxFit.cover,
                          networkImg: user.avatarUrl,
                          title: user.name ?? 'User',
                          desc: '@${user.username ?? 'user'}',
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            // Lazy Loaded Sections with Skeletons
            _buildProductSection(
                feedKey: "high-earning",
                title: "High Earning Products",
                iconAsset: Assets.imagesEarned,
                key: _feedKeys["high-earning"]),
            _buildProductSection(
                feedKey: "back-to-school",
                title: "Back to School",
                key: _feedKeys["back-to-school"]),
            _buildProductSection(
                feedKey: "trending",
                title: "Trending Now",
                iconAsset: Assets.imagesTrending,
                key: _feedKeys["trending"]),

            // Community Feed
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'Community Feed',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesTrending,
                isIconRight: true,
              ),
            ),
            Consumer<PostProvider>(
              builder: (context, postProvider, _) {
                final posts = postProvider.posts;
                if (posts.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text("No posts found")),
                  );
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 22),
                  child: Row(
                    children: posts.map((post) {
                      final image =
                          (post.media != null && post.media!.isNotEmpty)
                              ? post.media!.first
                              : null;
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () => Get.to(() => PostDisplay(post: post)),
                          child: CommonImageView(
                            url: image, // Network image
                            imagePath: image == null
                                ? Assets.imagesDummyimage2
                                : null, // Fallback
                            height: 330,
                            width: 225,
                            radius: 20,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            _buildProductSection(
                feedKey: "for-you",
                title: "For You",
                key: _feedKeys["for-you"]),
            _buildProductSection(
                feedKey: "local-product",
                title: "Local Products",
                key: _feedKeys["local-product"]),
          ],
        ),
      ),
    );
  }
}
