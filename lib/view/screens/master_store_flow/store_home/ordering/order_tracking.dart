import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/models/order_model.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/checkout.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _orderIdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleTrackOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = context.read<OrderProvider>();
      final orderId = _orderIdCtrl.text.trim();
      final order = await provider.getOrderById(orderId);

      if (order != null) {
        // Navigate to details
        Get.to(() => OrderDetailView(order: order));
      } else {
        Get.snackbar(
          "Not Found",
          "Could not find an order with that ID.",
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<OrderProvider>().isLoading;

    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          body: ImageLayoutWidget(
            bodyWidget: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ContainerAppbar(title: 'Track Order'),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: kgrey2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MyText(
                      text:
                          "Enter your order details below to view the current status.",
                      size: 14,
                      color: kbody,
                      useCustomFont: true,
                    ),
                  ),

                  // Email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: _emailCtrl,
                      label: 'Email',
                      hint: 'Enter email used for order',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                      // Since backend doesn't support generic email query for guests yet,
                      // we trust authorized user or just use it as UI decoration
                      readOnly: false,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Order ID Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: MyTextField(
                      controller: _orderIdCtrl,
                      label: 'Order ID',
                      hint: 'Enter Order ID',
                      radius: 8,
                      contentvPad: 10,
                      useCustomFont: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Order ID is required";
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Mybutton2(
                            buttonText: 'Track Order',
                            useCustomFont: true,
                            ontap: _handleTrackOrder,
                          ),
                  ),

                  const SizedBox(height: 20),
                  // Link to view all my orders
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          // Load all orders logic (if list screen existed)
                          // For now just show snackbar or future impl
                          await context.read<OrderProvider>().loadBuyerOrders();
                          final orders =
                              context.read<OrderProvider>().buyerOrders;
                          if (orders.isNotEmpty) {
                            // Could navigate to a list view
                            // Not implemented in this single file yet
                          }
                        },
                        child: MyText(
                          text: "View My Order History",
                          color: kheader,
                          size: 14,
                          weight: FontWeight.w600,
                          useCustomFont: true,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderDetailView extends StatelessWidget {
  final OrderModel order;
  const OrderDetailView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
                  child: ContainerAppbar(title: 'Order Details'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: kgrey2),
                ),

                // Status & Date
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomeContainer(
                      vpad: 15,
                      hpad: 15,
                      radius: 8,
                      color: kwhite,
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpandedRow(
                            text1: "Order ID",
                            text2: "#${order.id?.substring(0, 8) ?? 'NA'}",
                            size1: 14,
                            size2: 14,
                            color1: kbody,
                            color2: kblack,
                            weight2: FontWeight.bold,
                            useCustomFont: true,
                          ),
                          const SizedBox(height: 10),
                          ExpandedRow(
                            text1: "Status",
                            text2: order.status ?? "Pending",
                            size1: 14,
                            size2: 14,
                            color1: kbody,
                            color2: korange,
                            weight2: FontWeight.bold,
                            useCustomFont: true,
                          ),
                          const SizedBox(height: 10),
                          ExpandedRow(
                            text1: "Date",
                            text2: order.createdAt
                                    ?.toIso8601String()
                                    .split('T')
                                    .first ??
                                "",
                            size1: 14,
                            size2: 14,
                            color1: kbody,
                            color2: kblack,
                            useCustomFont: true,
                          ),
                        ],
                      )),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: MyText(
                      text: "Items",
                      size: 16,
                      weight: FontWeight.bold,
                      useCustomFont: true),
                ),
                const SizedBox(height: 10),

                // Items List (Reusing BagItemsRow logic roughly)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.orderItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = order.orderItems![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            store_image_stack(
                              height: 60,
                              width: 60,
                              showShadow: false,
                              showContent: false,
                              url: (item.product?.image?.isNotEmpty ?? false)
                                  ? item.product!.image!.first
                                  : null,
                              iconSize: 20,
                              radius: 8,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      text: item.product?.title ?? "Product",
                                      size: 15,
                                      weight: FontWeight.w600,
                                      useCustomFont: true),
                                  MyText(
                                      text: "Qty: ${item.quantity}",
                                      size: 12,
                                      color: kbody,
                                      useCustomFont: true),
                                ],
                              ),
                            ),
                            MyText(
                              text: '\$${(item.price ?? 0).toStringAsFixed(2)}',
                              size: 14,
                              color: kheader,
                              weight: FontWeight.w400,
                              useCustomFont: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Divider(color: kgrey2),
                ),
                const SizedBox(height: 10),

                // Totals (if available in model or re-calc)
                // Assuming payment amount is total
                if (order.payment != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ExpandedRow(
                      text1: "Total",
                      text2:
                          "\$${order.payment?.amount?.toStringAsFixed(2) ?? '0.00'}",
                      size1: 18,
                      size2: 18,
                      weight1: FontWeight.bold,
                      weight2: FontWeight.bold,
                      useCustomFont: true,
                    ),
                  ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        )
      ],
    );
  }
}
