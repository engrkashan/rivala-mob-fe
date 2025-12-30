import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/discovery/search_discovery_products.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/curated_brands.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/providers/post_provider.dart';
import '../../../controllers/providers/product_provider.dart';
import '../master_store_flow/store_menu/following_profile.dart';

class SocialCommerceHub extends StatefulWidget {
  const SocialCommerceHub({super.key});

  @override
  State<SocialCommerceHub> createState() => _SocialCommerceHubState();
}

class _SocialCommerceHubState extends State<SocialCommerceHub> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _loadedFeeds = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<BrandsProvider>().loadRecentBrands();
      if (!mounted) return;

      context.read<ProductProvider>().loadFeed("recent");
      _loadedFeeds.add("recent");

      final postProvider = context.read<PostProvider>();
      postProvider.loadCreators();
      postProvider.loadDiscoverPosts();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final triggerPoint = position.maxScrollExtent * 0.7;

    if (position.pixels > triggerPoint) {
      _lazyLoadFeeds();
    }
  }

  void _lazyLoadFeeds() {
    final feeds = [
      "high-earning",
      "back-to-school",
      "trending",
      "for-you",
      "local-product",
    ];

    final productProvider = context.read<ProductProvider>();

    for (final feed in feeds) {
      if (_loadedFeeds.contains(feed)) continue;

      _loadedFeeds.add(feed);
      productProvider.loadFeed(feed);
      debugPrint("Lazy loaded: $feed");
      break; // load ONE at a time (important)
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------- UI ----------------

  Widget _buildHorizontalBrandList() {
    return Consumer<BrandsProvider>(
      builder: (_, brands, __) {
        final recent = brands.store;

        if (recent == null) {
          return CircularProgressIndicator();
        }

        if (recent.isEmpty) {
          return const SizedBox(
            height: 150,
            child: Center(child: Text("No brands available")),
          );
        }

        return SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 22),
            scrollDirection: Axis.horizontal,
            itemCount: recent.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, index) {
              final brand = recent[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    // MaterialPageRoute(
                    //     builder: (_) => StoreMainProfile(
                    //           slug: brand.slug,
                    //         ))
                    CustomPageRoute(
                        page: FollowerMaiProfile(
                      store: brand,
                    ))),
                child: curated_brand_widget(
                  size: 135,
                  networkImg: brand.logoUrl ?? '',
                  title: brand.name ?? '',
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildProductSection({
    required String feedKey,
    required String title,
    String? iconAsset,
  }) {
    return Column(
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
            builder: (_, prd, __) {
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
                    onTap: () => Get.to(
                      () => ProductDetailedDescription(product: p),
                    ),
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
    );
  }

  Widget _SkeletonProductRow() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 22),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, __) => Container(
          width: 135,
          height: 180,
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
      body: ListView(
        controller: _scrollController,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Image.asset(
              Assets.imagesRivalalogo,
              height: 33,
              width: 148,
            ),
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
                  CustomPageRoute(page: const SearchDiscoveryProducts()),
                );
              },
            ),
          ),
          MyText(
            text: 'Recent Brands',
            size: 20,
            weight: FontWeight.bold,
            paddingLeft: 22,
            paddingBottom: 10,
          ),
          _buildHorizontalBrandList(),
          _buildProductSection(
            feedKey: "recent",
            title: "Recent Products",
          ),
          _buildProductSection(
            feedKey: "high-earning",
            title: "High Earning Products",
            iconAsset: Assets.imagesEarned,
          ),
          _buildProductSection(
            feedKey: "back-to-school",
            title: "Back to School",
          ),
          _buildProductSection(
            feedKey: "trending",
            title: "Trending Now",
            iconAsset: Assets.imagesTrending,
          ),
          _buildProductSection(
            feedKey: "for-you",
            title: "For You",
          ),
          _buildProductSection(
            feedKey: "local-product",
            title: "Local Products",
          ),
        ],
      ),
    );
  }
}
