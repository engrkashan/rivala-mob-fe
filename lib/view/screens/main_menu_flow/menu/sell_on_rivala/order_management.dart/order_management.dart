import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/my_order_widgets.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../../controllers/providers/order_provider.dart';
import '../../../../../widgets/my_text_widget.dart';

class OrderManagement extends StatefulWidget {
  final String? initialFilter;
  const OrderManagement({super.key, this.initialFilter});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialFilter != null) {
      _searchController.text = widget.initialFilter!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<OrderProvider>();
      provider.loadStoreOrders().then((_) {
        if (widget.initialFilter != null) {
          provider.searchOrders(widget.initialFilter!);
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Order Management', centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<OrderProvider>(builder: (context, ref, _) {
                final orders = ref.filteredOrders;
                return ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    MyTextField(
                      controller: _searchController,
                      hint: 'Search Order History',
                      prefixIcon: Image.asset(
                        Assets.imagesSearch,
                        width: 12,
                      ),
                      onChanged: (val) {
                        context.read<OrderProvider>().searchOrders(val);
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        if (ref.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (orders.isEmpty) {
                          return Center(
                              child: MyText(text: "No orders available"));
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: my_order_container(
                            hasfulfuill: true,
                            order: orders[index],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                );
              }),
            ),
          ],
        ));
  }
}
