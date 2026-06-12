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
import '../master_store_flow/store_home/main_profile.dart';
import '../master_flow/new_post/post_display.dart';
import '../../../models/store_model.dart';
import '../master_store_flow/store_menu/following_profile.dart';

class SocialCommerceHub extends StatefulWidget {
  const SocialCommerceHub({super.key});

  @override
  State<SocialCommerceHub> createState() => _SocialCommerceHubState();
}

class _SocialCommerceHubState extends State<SocialCommerceHub> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrollLoadingScheduled = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<BrandsProvider>().loadRecentBrands();
      context.read<ProductProvider>().loadFeed("recent");
      context.read<ProductProvider>().loadFeed("trending");
      context.read<ProductProvider>().loadFeed("back-to-school");
      context.read<ProductProvider>().loadFeed("picks-for-you");
      context.read<ProductProvider>().loadFeed("local-product");
      context.read<PostProvider>().loadCreators();
      context.read<PostProvider>().loadDiscoverPosts();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isScrollLoadingScheduled) return;
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final triggerPoint = position.maxScrollExtent * 0.7;

    if (position.pixels > triggerPoint) {
      _isScrollLoadingScheduled = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _isScrollLoadingScheduled = false;
      });
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

        // Loading state — same skeleton style as product rows
        if (recent == null) {
          return SizedBox(height: 180, child: _buildSkeletonProductRow());
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
                return _buildSkeletonProductRow();
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

  Widget _buildCreatorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: row_widget(
            title: "Recent Creators",
            texSize: 20,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 180,
          child: Consumer<PostProvider>(
            builder: (_, postProv, __) {
              final creators = postProv.creators;

              if (creators == null || (creators.isEmpty && postProv.isLoading)) {
                return _buildSkeletonProductRow();
              }

              if (creators.isEmpty) {
                return const SizedBox(
                  height: 150,
                  child: Center(child: Text("No creators found")),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.only(left: 22),
                scrollDirection: Axis.horizontal,
                itemCount: creators.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (_, index) {
                  final creator = creators[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomPageRoute(
                          page: StoreMainProfile(slug: creator.username),
                        ),
                      );
                    },
                    child: curated_brand_widget(
                      size: 135,
                      radius: 20,
                      fit: BoxFit.cover,
                      networkImg: creator.avatarUrl,
                      title: creator.name ?? creator.username ?? 'Creator',
                      desc: "@${creator.username ?? ''}",
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

  Widget _buildCommunityFeeds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: row_widget(
            title: "Community Feeds",
            texSize: 20,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 180,
          child: Consumer<PostProvider>(
            builder: (_, postProv, __) {
              final posts = postProv.posts;

              if (posts.isEmpty && postProv.isLoading) {
                return _buildSkeletonProductRow();
              }

              if (posts.isEmpty) {
                return const SizedBox(
                  height: 150,
                  child: Center(child: Text("No posts found")),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.only(left: 22),
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (_, index) {
                  final post = posts[index];
                  final image = (post.media != null && post.media!.isNotEmpty)
                      ? post.media!.first
                      : null;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        CustomPageRoute(
                          page: PostDisplay(post: post),
                        ),
                      // Navigator.push(
                      //   context,
                      //   CustomPageRoute(
                      //     page: PostDisplay(post: post),
                      //   ),
                      );
                    },
                    child: curated_brand_widget(
                      size: 135,
                      radius: 20,
                      fit: BoxFit.cover,
                      networkImg: image,
                      title: post.title ?? 'Post',
                      desc: "@${post.author?.username ?? ''}",
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

  Widget _buildSkeletonProductRow() {
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
            feedKey: "trending",
            title: "High Earning Products",
            iconAsset: Assets.imagesEarned,
          ),
          _buildProductSection(
            feedKey: "back-to-school",
            title: "Back to School",
          ),
          _buildProductSection(
            feedKey: "picks-for-you",
            title: "Picks for You",
          ),
          _buildProductSection(
            feedKey: "local-product",
            title: "Local Products",
          ),
          _buildCreatorsSection(),
          _buildCommunityFeeds(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
