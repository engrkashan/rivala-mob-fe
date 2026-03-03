import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/models/order_model.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

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
                            text2: order.orderNumber ??
                                "#${order.id?.substring(0, 8) ?? 'NA'}",
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
