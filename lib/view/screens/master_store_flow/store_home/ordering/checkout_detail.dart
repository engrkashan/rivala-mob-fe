import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; // ADDED
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/cart_provider.dart'; // ADDED
import 'package:rivala/controllers/providers/order_provider.dart'; // ADDED
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart'; // For BagItemsRow if needed
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/order_confirmation.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart'; // Needed if Mybutton2 is used
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/checkout_detail_widgets.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/expanded_row.dart';

class CheckoutDetail extends StatefulWidget {
  const CheckoutDetail({super.key});

  @override
  State<CheckoutDetail> createState() => _CheckoutDetailState();
}

class _CheckoutDetailState extends State<CheckoutDetail> {
  bool isOrderSummaryVisible = true;
  bool showShippingMethod = true;

  // Controllers for form fields
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController zipCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController fnameCtrl = TextEditingController();
  final TextEditingController lnameCtrl = TextEditingController();

  Future<void> _handlePlaceOrder() async {
    final cart = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();

    if (cart.items.isEmpty) {
      Get.snackbar("Error", "Your bag is empty");
      return;
    }

    // Basic validation
    // if (addressCtrl.text.isEmpty) {
    //   Get.snackbar("Error", "Please enter shipping address");
    //   return;
    // }

    // Construct payload
    // According to typical backend expectations
    final orderData = {
      "products": cart.items
          .map((item) => {
                "productId": item.product.id,
                "quantity": item.quantity,
                "size": item.size,
                "color": item.color
              })
          .toList(),
      "shippingAddress": {
        "address": addressCtrl.text,
        "city": cityCtrl.text,
        "zip": zipCtrl.text, // Add other fields if needed
      },
      "contact": {
        "phone": phoneCtrl.text,
        "firstName": fnameCtrl.text,
        "lastName": lnameCtrl.text,
      },
      "totalAmount":
          cart.totalAmount, // Backend might calculate this, but good to send
      "status": "PENDING" // Or whatever initial status
    };

    final success = await orderProvider.createOrder(orderData);
    if (success) {
      cart.clearCart();
      Get.off(() => OrderConfirmation());
    } else {
      Get.snackbar("Error", "Failed to place order: ${orderProvider.error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, _) {
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
                      title: 'Checkout',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: kgrey2),
                  ),
                  Center(
                    child: row_widget(
                      icon: Assets.imagesNutritionrescue,
                      title:
                          'Nutrition Rescue', // Could be dynamic based on store
                      weight: FontWeight.w600,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: kgrey2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOrderSummaryVisible = !isOrderSummaryVisible;
                            });
                          },
                          child: row_widget(
                            useCustomFont: true,
                            title: isOrderSummaryVisible
                                ? 'Hide order summary'
                                : 'Show order summary',
                            textColor: kheader,
                            iconData: isOrderSummaryVisible
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            isIconRight: true,
                          ),
                        ),
                        MyText(
                          text: '\$${cart.totalAmount.toStringAsFixed(2)}',
                          size: 16,
                          color: kblack,
                          weight: FontWeight.w700,
                          useCustomFont: true,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  //ORDER SUMMARY
                  if (isOrderSummaryVisible)
                    OrderSummaryWidget(
                        cart: cart,
                        placeOrder: false), // Use extracted/custom widget

                  //SHIPPING MENTHODS

                  MyText(
                    text: 'Shipping Method',
                    size: 18,
                    color: kblack,
                    paddingTop: 30,
                    paddingLeft: 18,
                    weight: FontWeight.w500,
                    paddingBottom: 20,
                    useCustomFont: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kgrey2,
                        ),
                        child: Column(
                          children: [
                            //MyText(text: ''),
                            ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: shipping_method_list(
                                    showShippingMethod:
                                        index == 0 ? true.obs : false.obs,
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  shipping_address_bool(),
                  Center(
                    child: MyText(
                      text: 'Express Checkout',
                      size: 18,
                      color: kbody,
                      weight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      paddingTop: 20,
                      paddingBottom: 10,
                      useCustomFont: true,
                    ),
                  ),
                  checkout_opts(),
                  SizedBox(
                    height: 10,
                  ),
                  checkout_opts(
                      icon: Assets.imagesPaypal, color: Color(0xffFFD140)),
                  SizedBox(
                    height: 10,
                  ),
                  checkout_opts(
                    icon: Assets.imagesGpay,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      label: 'Contact',
                      hint: 'janesmith@gmail.com',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: addressCtrl,
                      label: 'Shipping Address',
                      hint: 'United States',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: fnameCtrl,
                      hint: 'First Name',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: lnameCtrl,
                      hint: 'Last Name',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      hint: 'Address',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      hint: 'Apartment, suite, etc (optional)',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: cityCtrl,
                      hint: 'City',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      hint: 'State',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: zipCtrl,
                      hint: 'Zip Code',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: phoneCtrl,
                      hint: 'Phone',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                    ),
                  ),
                  MyText(
                    text: 'Payment',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                    paddingBottom: 8,
                    paddingTop: 15,
                    paddingLeft: 18,
                    useCustomFont: true,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kgrey2,
                        ),
                        child: Column(
                          children: [
                            //MyText(text: ''),
                            ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: payment_method_list(
                                    title:
                                        index == 1 ? 'Paypal' : 'Credit Card',
                                    showPaymentMethod:
                                        index == 0 ? true.obs : false.obs,
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  shipping_address_bool(),
                  SizedBox(
                    height: 20,
                  ),
                  // order_summary_container(
                  //   placeOrder: true,
                  // ),
                  OrderSummaryWidget(
                    cart: cart,
                    placeOrder: true,
                    onPlaceOrder: _handlePlaceOrder,
                    isLoading: context.watch<OrderProvider>().isLoading,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

// Re-using the structure but making it dynamic
class OrderSummaryWidget extends StatelessWidget {
  final CartProvider cart;
  final bool placeOrder;
  final VoidCallback? onPlaceOrder;
  final bool isLoading;

  const OrderSummaryWidget({
    super.key,
    required this.cart,
    required this.placeOrder,
    this.onPlaceOrder,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: kgrey2)),
        color: kgrey2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display items dynamically
          if (cart.items.isNotEmpty)
            Column(
              children: cart.items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: BagItemsRow(
                          title: item.product.title,
                          desc: item.product.store?.name,
                          img: item.product.image?.first,
                          showAmount: true, // Show price here
                          cartItem: item,
                          size: 80,
                        ),
                      ))
                  .toList(),
            ),

          if (placeOrder == false) ...{
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    radius: 8,
                    contentvPad: 3,
                    useCustomFont: true,
                    hint: 'Discount code or gift card',
                    filledColor: ktransparent,
                    marginBottom: 0,
                  ),
                ),
                const SizedBox(width: 8),
                buttonContainer(
                  text: 'APPLY',
                  useCustomFont: true,
                  radius: 8,
                  vPadding: 3,
                  txtColor: kdargrey,
                  bgColor: kblack.withOpacity(0.05),
                )
              ],
            ),
          },
          const SizedBox(height: 30),
          ExpandedRow(
            text1: 'Subtotal (${cart.itemCount})',
            text2: '\$${cart.totalAmount.toStringAsFixed(2)}',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          ExpandedRow(
            text1: 'Estimated Tax',
            text2: '\$0.00', // Hardcoded for now
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          // ExpandedRow(
          //   text1: 'Promo code',
          //   text2: '\$17.00',
          //   color1: kdargrey,
          //   color2: kdarkgrey,
          //   size1: 16,
          //   size2: 16,
          //   weight1: FontWeight.normal,
          //   weight2: FontWeight.normal,
          //    useCustomFont: true,
          // ),
          const SizedBox(height: 20),
          ExpandedRow(
            text1: 'Total',
            text2: '\$${cart.totalAmount.toStringAsFixed(2)}',
            color1: kblack2,
            color2: kblack2,
            size1: 16,
            size2: 16,
            weight1: FontWeight.w600,
            weight2: FontWeight.w600,
            useCustomFont: true,
          ),
          const SizedBox(height: 30),

          if (placeOrder == true)
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Mybutton2(
                    buttonText: 'Place order',
                    useCustomFont: true,
                    ontap: onPlaceOrder,
                  )
        ],
      ),
    );
  }
}

class shipping_address_bool extends StatelessWidget {
  const shipping_address_bool({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckBox(
            isActive: true,
            onTap: () {},
            radius: 5,
          ),
          Expanded(
              child: MyText(
            text: 'Use shipping address as billing address',
            size: 13,
            color: kbody,
            paddingLeft: 5,
            useCustomFont: true,
          ))
        ],
      ),
    );
  }
}

class checkout_opts extends StatelessWidget {
  final String? icon;
  final VoidCallback? ontap;
  final Color? color;
  const checkout_opts({
    super.key,
    this.icon,
    this.ontap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Bounce_widget(
        ontap: ontap,
        widget: CustomeContainer(
          radius: 8,
          vpad: 9,
          color: color ?? kblack,
          widget: Center(
              child: Image.asset(
            icon ?? Assets.imagesApplepay,
            width: 58,
            height: 23,
          )),
        ),
      ),
    );
  }
}
