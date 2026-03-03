import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/pages_provider.dart';
import 'package:rivala/models/page_model.dart';
import 'package:rivala/controllers/providers/promo_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/add_page_section.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/main_menu_widgets/custom_divider.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class PagesAboutus extends StatefulWidget {
  final PageModel? page;
  const PagesAboutus({super.key, this.page});

  @override
  State<PagesAboutus> createState() => _PagesAboutusState();
}

class _PagesAboutusState extends State<PagesAboutus> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.page?.id != null) {
        context.read<PagesProvider>().loadPageBySlug(widget.page!.slug!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: widget.page?.title ?? 'About Us',
        centerTitle: true,
      ),
      body: Consumer<PagesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final page = provider.currentPage ?? widget.page;
          final sections = page?.sections ?? [];

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (sections.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.layers_outlined,
                            size: 64, color: kgreyy),
                        const SizedBox(height: 16),
                        const Text(
                          "Your page is currently empty",
                          style: TextStyle(
                              color: kgreyy,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => Get.bottomSheet(
                            AddPageSection(
                              pageId: provider.currentPage?.id ??
                                  widget.page?.id ??
                                  '',
                              insertIndex: 0,
                            ),
                            isScrollControlled: true,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kblue,
                            foregroundColor: kwhite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Add First Section"),
                        ),
                      ],
                    ),
                  )
                else ...[
                  ...List.generate(sections.length, (index) {
                    return _buildSection(sections[index]);
                  }),
                  const SizedBox(height: 10),
                  CustomDivider(
                    ontap: () => Get.bottomSheet(
                      AddPageSection(
                        pageId:
                            provider.currentPage?.id ?? widget.page?.id ?? '',
                        insertIndex: sections.length,
                      ),
                      isScrollControlled: true,
                    ),
                  ),
                ],
                const SizedBox(
                    height:
                        100), // More bottom space to ensure divider is visible
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(PageSectionModel section) {
    final type = (section.type ?? '').trim().toUpperCase();
    switch (type) {
      case 'RECENT-PRODUCTS':
      case 'RECENT_PRODUCTS':
        return SectionProducts(section: section);
      case 'COLLECTION':
        return SectionCollection(section: section);
      case 'SQUAD':
        return SectionSquad(section: section);
      case 'PROMO-BANNER':
      case 'PROMO_BANNER':
        return SectionPromoBanner(section: section);
      case 'MEDIA':
        return SectionMedia(section: section);
      case 'TEXT-SECTION':
      case 'TEXT_SECTION':
        return SectionText(section: section);
      default:
        return const SizedBox.shrink();
    }
  }

  /// This method is a placeholder for future backend-driven population.
  /// Currently, the backend only populates RECENT_PRODUCTS.
  /// When SQUAD or COLLECTION types are supported by the backend, this logic can be updated.
  // ignore: unused_element
  Future<void> _populateSectionData(PageSectionModel section) async {
    // TODO: Implement manual fetching if backend doesn't populate section data.
    // For now, we rely on the data passed during section creation in AddPageSection.
  }
}

class SectionCollection extends StatelessWidget {
  final PageSectionModel section;
  const SectionCollection({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    // Collections show products, so we can reuse SectionProducts if we ensure it uses the products from the section.
    return SectionProducts(
      section: section,
      defaultTitle: 'Collection',
    );
  }
}

class SectionSquad extends StatelessWidget {
  final PageSectionModel section;
  const SectionSquad({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> members = section.settings?['members'] ?? [];
    final heading = section.settings?['heading'] ?? 'Squad';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 5),
          child: Text(
            heading,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kheader,
            ),
          ),
        ),
        if (members.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text("No members found")),
          )
        else
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(members.length, (index) {
                final member = members[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Column(
                    children: [
                      CommonImageView(
                        url: member['avatarUrl'],
                        imagePath:
                            'assets/images/user_placeholder.png', // Fallback
                        width: 60,
                        height: 60,
                        radius: 30,
                      ),
                      const SizedBox(height: 5),
                      MyText(
                        text: member['name'] ?? 'User',
                        size: 12,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

class SectionProducts extends StatefulWidget {
  final PageSectionModel section;
  final String? defaultTitle;
  const SectionProducts({super.key, required this.section, this.defaultTitle});

  @override
  State<SectionProducts> createState() => _SectionProductsState();
}

class _SectionProductsState extends State<SectionProducts> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadCurrentProducts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        // Strict logic: Use backend data if available.
        // If the backend actually populates data, section.products will be a List (empty or not).
        // If section.products is NULL, it means no population happened, so we fallback.
        final sectionProducts = widget.section.products;
        final List<ProductModel> products;
        final bool isLoading;

        if (sectionProducts != null) {
          products = sectionProducts;
          isLoading = false;
        } else {
          products = provider.prds ?? [];
          isLoading = provider.isLoading;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 22, right: 22, top: 10, bottom: 5),
              child: Text(
                widget.section.settings?['heading'] ??
                    widget.defaultTitle ??
                    'Recent Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kheader,
                ),
              ),
            ),
            if (isLoading && products.isEmpty)
              const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (products.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text("No products found")),
              )
            else
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(products.length, (index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: store_image_stack(
                        title: product.title,
                        price: product.price?.toString(),
                        url: product.image?.isNotEmpty == true
                            ? product.image!.first
                            : null,
                        onTap: () {
                          // Navigate to product details if needed
                        },
                      ),
                    );
                  }),
                ),
              ),
          ],
        );
      },
    );
  }
}

class SectionPromoBanner extends StatefulWidget {
  final PageSectionModel section;
  const SectionPromoBanner({super.key, required this.section});

  @override
  State<SectionPromoBanner> createState() => _SectionPromoBannerState();
}

class _SectionPromoBannerState extends State<SectionPromoBanner> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PromoProvider>().setPromos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PromoProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.promos.isEmpty) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final promos = provider.promos;

        if (promos.isEmpty) {
          // Show default banner from settings if no actual promos
          final imageUrl = widget.section.settings?['image'];
          final heading =
              widget.section.settings?['heading'] ?? 'Special Offer';

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kblue.withOpacity(0.1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    CommonImageView(
                      url: imageUrl,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: heading,
                          color: kwhite,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show the latest promo
        final promo = promos.first;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: kblue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: promo.title ?? 'Special Sale',
                  color: kwhite,
                  size: 20,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 5),
                MyText(
                  text: promo.description ?? 'Check out our latest offers!',
                  color: kwhite.withOpacity(0.8),
                  size: 14,
                ),
                if (promo.promoCode != null)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MyText(
                      text: "Code: ${promo.promoCode}",
                      color: kblue,
                      weight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SectionMedia extends StatelessWidget {
  final PageSectionModel section;
  const SectionMedia({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final imageUrl = section.settings?['image'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CommonImageView(
          url: (imageUrl != null && imageUrl.isNotEmpty) ? imageUrl : null,
          imagePath: (imageUrl == null || imageUrl.isEmpty)
              ? 'assets/images/no_image_found.png'
              : null,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final PageSectionModel section;
  const SectionText({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final description = section.settings?['description'] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: section.title ?? 'About',
            color: kheader,
            size: 24,
            weight: FontWeight.bold,
            paddingBottom: 15,
            useCustomFont: true,
          ),
          MyText(
            text: description,
            color: kbody,
            size: 14,
            lineHeight: 1.6,
            useCustomFont: true,
          ),
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 2,
            color: kheader,
          ),
        ],
      ),
    );
  }
}
