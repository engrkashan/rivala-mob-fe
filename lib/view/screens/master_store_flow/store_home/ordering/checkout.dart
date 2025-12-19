import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/cart_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout_detail.dart';

import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';

import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';

import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';

import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class ProductCheckout extends StatelessWidget {
  const ProductCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      return Stack(
        children: [
          dummyimgeStack(),
          Scaffold(
              backgroundColor: ktransparent,
              body: ImageLayoutWidget(
                bodyWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ContainerAppbar(
                          title: 'My Bag (${cart.itemCount} Items)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(color: kgrey2),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: CustomeContainer(
                        vpad: 8,
                        hpad: 8,
                        radius: 8,
                        borderColor: korange,
                        color: korange.withOpacity(0.2),
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.imagesAlert,
                              width: 15,
                              height: 15,
                            ),
                            Expanded(
                                child: MyText(
                              text:
                                  'Items in bag are not reserved. Checkout now to get your gear.',
                              color: korange,
                              paddingLeft: 8,
                              useCustomFont: true,
                            ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (cart.items.isEmpty)
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Your bag is empty"),
                      ))
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: BagItemsRow(
                              title: item.product.title,
                              desc: item.product.store?.name,
                              img: item.product.image?.first,
                              size: 54,
                              showAmount: false,
                              cartItem: item,
                              index: index,
                            ),
                          );
                        },
                      ),

                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: kgrey2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ExpandedRow(
                        text1: 'Estimated Total',
                        text2: '\$${cart.totalAmount.toStringAsFixed(2)}',
                        size1: 16,
                        size2: 16,
                        color1: kheader, //kheader,
                        color2: kheader,
                        weight1: FontWeight.w600,
                        useCustomFont: true,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ExpandedRow(
                        text1: 'Tax',
                        text2: 'Calculated at checkout',
                        size1: 16,
                        size2: 16,
                        color1: kbody, //kheader,
                        color2: kbody,
                        weight1: FontWeight.w600,
                        useCustomFont: true,
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    //const SizedBox(height: 20),
                  ],
                ),
                buttonText: 'Checkout',
                ontap: () {
                  if (cart.items.isNotEmpty) {
                    Get.to(() => CheckoutDetail());
                  }
                },
              )),
        ],
      );
    });
  }
}

class BagItemsRow extends StatelessWidget {
  final String? title, desc, img;
  final double? size;
  final bool? showAmount;
  final CartItem? cartItem;
  final int? index;

  const BagItemsRow({
    super.key,
    this.title,
    this.desc,
    this.img,
    this.showAmount = false,
    this.size,
    this.cartItem,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          store_image_stack(
            height: size ?? 54,
            width: size ?? 54,
            showShadow: false,
            showContent: false,
            // Use the real image URL if available
            url: img,
            iconSize: 20,
            radius: 8,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: TwoTextedColumn(
            text1: title ?? 'Product Name',
            text2: showAmount == true ? '' : desc ?? 'Store Name',
            mBottom: 2,
            size2: 10,
            size1: 15,
            useCustomFont: true,
            weight1: FontWeight.w600,
          )),
          if (showAmount == true)
            MyText(
              text: '\$${cartItem?.totalPrice ?? 0.0}',
              size: 14,
              color: kheader,
              weight: FontWeight.w400,
              useCustomFont: true,
            ),
          if (showAmount == false)
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (index != null) {
                      context.read<CartProvider>().removeFromCart(index!);
                    }
                  },
                  child: row_widget(
                    icon: Assets.imagesTrash,
                    iconSize: 12,
                    title: 'remove',
                    texSize: 10,
                    textColor: kgreyy,
                    useCustomFont: true,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                if (index != null) AddItemss(index: index!)
              ],
            )
        ],
      ),
    );
  }
}

class AddItemss extends StatelessWidget {
  final int index;
  const AddItemss({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, _) {
      // Safe check to avoid range error if item removed
      if (index >= cart.items.length) return const SizedBox();
      final quantity = cart.items[index].quantity;

      return CustomeContainer(
        vpad: 2,
        radius: 5,
        hpad: 8,
        color: kgreyy.withOpacity(0.2),
        widget: Row(
          children: [
            Bounce_widget(
                ontap: () => cart.decrementQuantity(index),
                widget: Image.asset(
                  Assets.imagesMinuss,
                  color: kblack,
                  width: 12,
                )),
            SizedBox(
              width: 4,
            ),
            CustomeContainer(
              vpad: 2,
              hpad: 6,
              radius: 3,
              color: kwhite,
              widget: MyText(
                text: quantity.toString(),
                size: 9,
                useCustomFont: true,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Bounce_widget(
                ontap: () => cart.incrementQuantity(index),
                widget: Image.asset(
                  Assets.imagesAdd2,
                  color: kblack,
                  width: 12,
                )),
          ],
        ),
      );
    });
  }
}
