import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/order_detail_view.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';

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
      final email = _emailCtrl.text.trim();
      final order =
          await provider.trackOrder(orderNumber: orderId, email: email);

      if (order != null) {
        // Navigate to details
        Get.to(() => OrderDetailView(order: order));
      } else {
        AlertInfo.show(
          context: context,
          text: "Could not find an order with that ID.",
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
