import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/cart_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/cart_model.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/utils/color_utils.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/size_guide_bottom_sheet.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/review_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/main_profile.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/slider_button.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/product_desc_widgets.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'main_profile.dart';

class ProductDetailedDescription extends StatefulWidget {
  final ProductModel product;
  const ProductDetailedDescription({super.key, required this.product});

  @override
  State<ProductDetailedDescription> createState() =>
      _ProductDetailedDescriptionState();
}

class _ProductDetailedDescriptionState
    extends State<ProductDetailedDescription> {
  final PageController _pageController = PageController();

  String? selectedSize;
  String? selectedColor;
  int _quantity = 1;
  String _purchaseOption = "one-time";
  String _subscriptionFrequency = "Every month";
  bool _inWishlist = false;

  @override
  void initState() {
    super.initState();
    _checkWishlist();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prdd = Provider.of<ProductProvider>(context, listen: false);
      await prdd.loadForYou(widget.product.id ?? "");
      await prdd.loadPrdReviews(widget.product.id ?? "");
    });
  }

  Future<void> _checkWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlist = prefs.getStringList('wishlist') ?? [];
    if (mounted) {
      setState(() {
        _inWishlist = wishlist.contains(widget.product.id);
      });
    }
  }

  Future<void> _toggleWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlist = prefs.getStringList('wishlist') ?? [];
    final id = widget.product.id;
    if (id == null) return;

    if (wishlist.contains(id)) {
      wishlist.remove(id);
      setState(() => _inWishlist = false);
      Get.snackbar('Removed', 'Removed from wishlist', duration: const Duration(seconds: 1));
    } else {
      wishlist.add(id);
      setState(() => _inWishlist = true);
      Get.snackbar('Added', 'Added to wishlist', duration: const Duration(seconds: 1));
    }
    await prefs.setStringList('wishlist', wishlist);
  }

  @override
  Widget build(BuildContext context) {
    final prd = widget.product;
    final List<String> sizes = prd.sizes ?? [];
    final List<String> colors = prd.colors ?? [];

    return Stack(
      children: [
        Scaffold(
            backgroundColor: ktransparent,
            body: ImageLayoutWidget(
              store: prd.store,
              ontap: () {
                Get.to(
                      () => StoreMainProfile(
                    slug: prd.store?.slug,
                  ),
                );
              },
              bodyWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child:
                        ContainerAppbar(title: prd.store?.name ?? "Shop Name"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: kgrey2),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SizedBox(
                        height: 350,
                        width: Get.width,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: prd.image?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CommonImageView(
                                  url: prd.image?[index],
                                  width: Get.width,
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if ((prd.image?.length ?? 0) > 1)
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: prd.image?.length ?? 0,
                        effect: JumpingDotEffect(
                          activeDotColor: kheader,
                          dotColor: kgrey2,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TwoTextedColumn(
                      text1: prd.title ?? "",
                      text2: '\$${prd.price ?? "0.00"}',
                      size1: 20,
                      size2: 20,
                      color1: kbody,
                      color2: kbody,
                      weight1: FontWeight.w600,
                      useCustomFont: true,
                    ),
                  ),
                  
                  // Stock Status
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: (prd.stockQuantity ?? 0) == 0
                                ? Colors.red.shade100
                                : ((prd.stockQuantity ?? 0) < 10
                                    ? Colors.orange.shade100
                                    : Colors.green.shade100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            (prd.stockQuantity ?? 0) == 0
                                ? "Out of Stock"
                                : ((prd.stockQuantity ?? 0) < 10
                                    ? "Low Stock"
                                    : "In Stock"),
                            style: TextStyle(
                              color: (prd.stockQuantity ?? 0) == 0
                                  ? Colors.red.shade800
                                  : ((prd.stockQuantity ?? 0) < 10
                                      ? Colors.orange.shade800
                                      : Colors.green.shade800),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if ((prd.stockQuantity ?? 0) > 0) ...[
                          const SizedBox(width: 10),
                          Text(
                            "${prd.stockQuantity} items left",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  if (colors.isNotEmpty) ...[
                    MyText(
                      text: 'Select Color',
                      size: 14,
                      color: kheader,
                      weight: FontWeight.w500,
                      paddingLeft: 18,
                      paddingBottom: 8,
                      useCustomFont: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SizedBox(
                        height: 55,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: colors.length,
                          itemBuilder: (context, index) {
                            final String hexColor = colors[index];
                            final Color color = hexColor.toColor();
                            final bool isSelected = selectedColor == hexColor;

                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = hexColor;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: isSelected ? kblack : Colors.transparent,
                                        width: 2.5),
                                  ),
                                  padding: const EdgeInsets.all(2.5),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 6,
                                          spreadRadius: 2,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 15,
                  ),

                  if (sizes.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Select Size',
                            size: 14,
                            color: kheader,
                            weight: FontWeight.w500,
                            useCustomFont: true,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const SizeGuideBottomSheet(),
                              );
                            },
                            child: MyText(
                              text: 'Size Guide',
                              size: 12,
                              color: Colors.blue,
                              weight: FontWeight.w500,
                              useCustomFont: true,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 15),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: sizes.map((size) {
                          bool isSelected = selectedSize == size;
                          return buttonContainer(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            borderColor: isSelected ? kblack : kgrey2,
                            bgColor:
                                isSelected ? kblack : kgrey3.withOpacity(0.5),
                            radius: 8,
                            hPadding: 12,
                            vPadding: 5,
                            text: size,
                            txtColor: isSelected ? kwhite : kblack,
                            textsize: 16,
                            useCustomFont: true,
                          );
                        }).toList(),
                      ),
                    ),
                  ],

                  MyText(
                    text: 'Purchase Options',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    useCustomFont: true,
                  ),

                  // Purchase Options
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _purchaseOption = "one-time"),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _purchaseOption == "one-time" ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: _purchaseOption == "one-time" ? Colors.black : Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                MyText(text: 'One-Time Purchase', color: Colors.blueGrey, size: 14),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => setState(() => _purchaseOption = "subscription"),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      _purchaseOption == "subscription" ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                      color: _purchaseOption == "subscription" ? Colors.black : Colors.grey,
                                    ),
                                    const SizedBox(width: 10),
                                    MyText(text: 'Subscription', color: Colors.blueGrey, size: 14),
                                  ],
                                ),
                                if (_purchaseOption == "subscription") ...[
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _subscriptionFrequency,
                                        isExpanded: true,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        items: ['Every month', 'Every two months', 'Every two weeks']
                                            .map((String val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(val, style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          if (val != null) {
                                            setState(() => _subscriptionFrequency = val);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quantity Selector
                  MyText(
                    text: 'Quantity',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    paddingTop: 20,
                    useCustomFont: true,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ProductQuantity(onChanged: (val) {
                        setState(() {
                          _quantity = val;
                        });
                      })),
                  SizedBox(height: 15),

                  MyText(
                    text: "Description",
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    paddingTop: 20,
                    useCustomFont: true,
                  ),
                  MyText(
                    text: prd.description ?? "",
                    size: 12,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    useCustomFont: true,
                  ),

                  // "You might also like" section
                  if (Provider.of<ProductProvider>(context).recommendedPrds?.isNotEmpty ??
                      false) ...[
                    MyText(
                      text: 'You might also like',
                      size: 14,
                      color: kheader,
                      weight: FontWeight.w400,
                      paddingLeft: 18,
                      paddingBottom: 10,
                      paddingTop: 20,
                      useCustomFont: true,
                    ),
                    Consumer<ProductProvider>(
                        builder: (context, recommended, child) {
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(recommended.recommendedPrds?.length ?? 0,
                              (index) {
                            final prd = recommended.recommendedPrds![index];
                            final String? firstImage =
                                (prd.image?.isNotEmpty == true)
                                    ? prd.image!.first
                                    : null;

                            return Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: store_image_stack(
                                quickbut: true,
                                url: firstImage,
                                title: prd.title,
                                price: prd.price.toString(),
                                singlePrice: true,
                                onTap: () {
                                  Get.to(
                                    () => ProductDetailedDescription(
                                      product: prd,
                                    ),
                                    preventDuplicates: false,
                                  );
                                },
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ],

                  // More Items Banner
                  if (prd.store?.slug != null && prd.store!.slug!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => StoreMainProfile(slug: prd.store!.slug));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.storefront, color: Colors.grey.shade700, size: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "More items in the store",
                                      style: TextStyle(color: Colors.grey.shade800, fontSize: 13),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "@${prd.store!.slug}",
                                      style: const TextStyle(
                                          color: Color(0xFF1D6FA3),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey.shade500),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Reviews Section (kept as is)
                  Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      final reviews = provider.prdReviews ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, top: 20, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: 'Customer Reviews',
                                  size: 15,
                                  color: kheader,
                                  weight: FontWeight.w500,
                                  useCustomFont: true,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (prd.id != null) {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => ReviewBottomSheet(productId: prd.id!),
                                      );
                                    }
                                  },
                                  child: MyText(
                                    text: 'Write a Review',
                                    size: 13,
                                    color: Colors.blue,
                                    weight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    useCustomFont: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (reviews.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              child: Text(
                                "No reviews yet. Be the first to write a review!",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                            )
                          else
                            SizedBox(
                            height: 260,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                final review = reviews[index];
                                return Container(
                                  width: 300,
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage:
                                                review.user?.avatarUrl != null
                                                    ? NetworkImage(
                                                        review.user!.avatarUrl!)
                                                    : null,
                                            child: review.user?.avatarUrl ==
                                                    null
                                                ? Text(
                                                    review.user?.username?[0]
                                                            .toUpperCase() ??
                                                        "A",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  review.user?.name ??
                                                      "Anonymous",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 2),
                                                _buildStars(review.rating ?? 5),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      // Title
                                      if (review.title?.isNotEmpty == true)
                                        Text(
                                          review.title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.5),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                      const SizedBox(height: 6),

                                      // Content
                                      Text(
                                        review.content ?? "",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade700,
                                            height: 1.45),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(height: 12),
                                      const Spacer(),

                                      // Date at bottom right
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          review.createdAt != null
                                              ? _simpleDate(review.createdAt!)
                                              : "Just now",
                                          style: TextStyle(
                                              fontSize: 10.5,
                                              color: Colors.grey.shade500),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 30),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: CustomeContainer(
                      hasShadow: true,
                      color: kwhite,
                      radius: 50,
                      vpad: 8,
                      mbott: 0,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: BottomButtons(
                                  icon: Assets.imagesBack2,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: _toggleWishlist,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Icon(
                                    _inWishlist ? Icons.favorite : Icons.favorite_border,
                                    color: _inWishlist ? Colors.red : Colors.grey.shade700,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              context.read<CartProvider>().addToCart(
                                    CartItem(
                                      product: widget.product,
                                      quantity: _quantity,
                                      size: selectedSize,
                                      color: selectedColor,
                                    ),
                                  );
                              Get.to(() => ProductCheckout());
                            },
                            child: SimpleExample(
                              trackHeight: 40,
                            ),
                          ),

                          // View Bag Button
                          GestureDetector(
                            onTap: () => Get.to(() => ProductCheckout()),
                            child: CircleAvatar(
                              backgroundColor: kblack,
                              child: Icon(Icons.shopping_bag_outlined,
                                  color: kwhite, size: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating ? Icons.star_rounded : Icons.star_border_rounded,
          size: 14,
          color: Colors.amber.shade700,
        );
      }),
    );
  }

  String _simpleDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays < 1) return "Today";
    if (diff.inDays < 7) return "${diff.inDays}d ago";
    if (diff.inDays < 30) return "${(diff.inDays / 7).floor()}w ago";
    return "${date.month}/${date.day}";
  }
}
