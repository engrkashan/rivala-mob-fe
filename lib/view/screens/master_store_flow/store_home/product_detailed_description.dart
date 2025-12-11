import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/utils/color_utils.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/slider_button.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/product_desc_widgets.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prdd = Provider.of<ProductProvider>(context, listen: false);
      await prdd.loadForYou(widget.product.id ?? "");
      await prdd.loadPrdReviews(widget.product.id ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    final prd = widget.product;
    final List<String> sizes = prd.sizes ?? [];
    final List<String> colors = prd.colors ?? [];
    print("Hello Store Url ${prd.store?.logoUrl}");
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
            backgroundColor: ktransparent,
            body: ImageLayoutWidget(
              store: prd.store,
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
                                  // imagePath: prd.image?[index],
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 18),
                  //   child: Row(
                  //     children: [
                  //       buttonContainer(
                  //         bgColor: ktransparent,
                  //         imagePath: Assets.imagesGift,
                  //         text: '15% off with code SUNFUN',
                  //         txtColor: kgreen,
                  //         iconColor: kgreen,
                  //         textsize: 10,
                  //         imageSize: 11,
                  //         vPadding: 2,
                  //         hPadding: 3,
                  //         useCustomFont: true,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TwoTextedColumn(
                      text1: prd.title ?? "",
                      text2: '\$${prd.price}',
                      size1: 20,
                      size2: 20,
                      color1: kbody, //kheader,
                      color2: kbody,
                      weight1: FontWeight.w600,
                      useCustomFont: true,
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
                          itemCount: (colors ?? []).length,
                          itemBuilder: (context, index) {
                            final String hexColor = colors[index];
                            final Color color =
                                hexColor.toColor(); // Using the extension
                            var selectedColor;
                            final bool isSelected = selectedColor == hexColor;

                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 12), // spacing between colors
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor =
                                        hexColor; // store the hex string
                                  });
                                },
                                child: color_picker(
                                  bgColor: color,
                                  size: 48,
                                  showShadow: true,
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
                  //size seltc
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ExpandedRow(
                      text1: 'Select Size',
                      text2: 'Size Guide',
                      color2: kblue,
                      size1: 14,
                      size2: 14,
                      weight1: FontWeight.w500,
                      weight2: FontWeight.w500,
                      color1: kheader,
                      decoration2: TextDecoration.underline,
                      useCustomFont: true,
                    ),
                  ),
                  //size guideee
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: sizes.map((size) {
                        bool isSelected = selectedSize == size;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: buttonContainer(
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
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  //
                  MyText(
                    text: 'Purchase Options',
                    size: 14,
                    color: kheader,
                    weight: FontWeight.w400,
                    paddingLeft: 18,
                    paddingBottom: 10,
                    useCustomFont: true,
                  ),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: PurchaseOptsWidget(
                        title: 'One-Time Purchase',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: PurchaseOptsWidget(
                        hasDropdown: true,
                      )),
                  /////qunatty
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
                      child: ProductQuantity()),
                  SizedBox(
                    height: 15,
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: 4,
                  //   itemBuilder: (context, index) {
                  //     return CustomAccordion(
                  //       title: 'Menu ${index + 1}',
                  //     );
                  //   },
                  // ),

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

                  /////other opts
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
                        children: List.generate(recommended.prds?.length ?? 0,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: store_image_stack(
                              quickbut: true,
                              url: recommended.prds?[index].image?.first,
                              title: recommended.prds?[index].title,
                              price: recommended.prds?[index].price.toString(),
                              singlePrice: true,
                              onTap: () {
                                Get.to(() => PostDisplay(
                                      product: recommended.prds?[index],
                                    ));
                              },
                            ),
                          );
                        }),
                      ),
                    );
                  }),

                  /////customer reviews
                  Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      final reviews = provider.prdReviews ?? [];

                      if (reviews.isEmpty) {
                        return const SizedBox();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18, top: 20, bottom: 12),
                            child: MyText(
                              text: 'Customer Reviews',
                              size: 15,
                              color: kheader,
                              weight: FontWeight.w500,
                              useCustomFont: true,
                            ),
                          ),
                          SizedBox(
                            height: 260, // Enough for text + small images
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
                                      // User + Rating
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

                                      // Small Review Images (Horizontal scroll if many)
                                      if (review.images != null &&
                                          review.images!.isNotEmpty)
                                        SizedBox(
                                          height: 60,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: review.images!.length,
                                            itemBuilder: (context, imgIndex) {
                                              final imgUrl =
                                                  review.images![imgIndex];
                                              return Container(
                                                width: 50,
                                                height: 50,
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    imgUrl,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context,
                                                        child, progress) {
                                                      return progress == null
                                                          ? child
                                                          : Container(
                                                              color: Colors.grey
                                                                  .shade100);
                                                    },
                                                    errorBuilder:
                                                        (_, __, ___) =>
                                                            Container(
                                                      color:
                                                          Colors.grey.shade100,
                                                      child: const Icon(
                                                          Icons.broken_image,
                                                          size: 20,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),

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

                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomeContainer(
                      radius: 15,
                      vpad: 8,
                      hpad: 8,
                      borderColor: kgrey2,
                      widget: Row(
                        children: [
                          Image.asset(
                            Assets.imagesStore2,
                            width: 44,
                            height: 44,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TwoTextedColumn(
                              text1: 'More items in the store',
                              text2: prd.store?.name ?? "",
                              size1: 14,
                              size2: 16,
                              weight1: FontWeight.w500,
                              weight2: FontWeight.w600,
                              color1: kheader,
                              color2: kblue,
                              useCustomFont: true,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: kblack,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                          BottomButtons(
                            icon: Assets.imagesBack2,
                          ),
                          SimpleExample(
                            trackHeight: 40,
                            callback: () {
                              Get.to(() => ProductCheckout());
                            },
                            stretchThumb: true,
                            resetCurve: Curves.bounceOut,
                            resetDuration: const Duration(milliseconds: 3000),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //const SizedBox(height: 20),
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
