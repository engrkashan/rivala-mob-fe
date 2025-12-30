import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/payment_methods_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/payment/payment_detail.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PaymentManagement extends StatefulWidget {
  const PaymentManagement({super.key});

  @override
  State<PaymentManagement> createState() => _PaymentManagementState();
}

class _PaymentManagementState extends State<PaymentManagement> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        context.read<PaymentMethodsProvider>().loadPaymentMethods();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Payment Management', centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Consumer<PaymentMethodsProvider>(
                    builder: (context, ref, _) {
                      return ListView.builder(
                        itemCount: ref.paymentMethods?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final card = ref.paymentMethods?[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ShoppingRow(
                              ontap: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                      page: PaymentDetail(
                                    model: card,
                                  )),
                                );
                              },
                              isSelected: false,
                              mleft: 0,
                              justIcon: true,
                              weight: FontWeight.w500,
                              textt: '${card?.cardNumber}',
                              mrigth: 0,
                              // icon: card?.!,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  MyText(
                    text: '+ Add new payment method',
                    size: 15,
                    weight: FontWeight.w400,
                    color: kblue,
                    paddingTop: 35,
                    paddingBottom: 15,
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                            page: PaymentDetail(
                          newBank: true,
                        )),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
