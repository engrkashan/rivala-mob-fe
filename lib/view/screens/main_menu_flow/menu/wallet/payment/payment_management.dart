import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/payment_methods_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/payment/payment_detail.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../generated/assets.dart';

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
                      if (ref.isLoading) {
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(color: kblack),
                        ));
                      }
                      
                      if (ref.paymentMethods == null || ref.paymentMethods!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Column(
                            children: [
                              Image.asset(Assets.imagesBankinfo, height: 60, color: Colors.grey.shade400),
                              const SizedBox(height: 15),
                              MyText(
                                text: "No payment methods added yet! 💳✨",
                                size: 16,
                                color: Colors.grey.shade600,
                                weight: FontWeight.w500,
                              ),
                              const SizedBox(height: 5),
                              MyText(
                                text: "Add a card or bank account to easily manage your purchases.",
                                size: 12,
                                color: Colors.grey.shade500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: ref.paymentMethods!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final card = ref.paymentMethods![index];
                          String cardBrandStr = ref.detectCardBrand(card.cardNumber ?? '');
                          String? displayIcon;
                          String displayText = card.cardNumber ?? '';

                          if (card.type == 'CARD') {
                            if (cardBrandStr == 'visa') {
                              displayIcon = Assets.imagesVisa;
                            } else if (cardBrandStr == 'mastercard') {
                              displayIcon = Assets.imagesMastercard;
                            } else {
                              displayIcon = Assets.imagesBankinfo;
                            }
                            
                            if (displayText.length > 4) {
                              displayText = '•••• •••• •••• ${displayText.substring(displayText.length - 4)}';
                            }
                          } else if (card.type == 'BANK') {
                            displayIcon = Assets.imagesBankinfo;
                            String accNum = card.accountNumber ?? '';
                            if (accNum.length > 4) {
                              accNum = '••••${accNum.substring(accNum.length - 4)}';
                            }
                            displayText = '${card.bankName ?? 'Bank Account'} $accNum';
                          } else {
                            displayIcon = Assets.imagesBankinfo;
                            displayText = card.walletProvider ?? 'Digital Wallet';
                          }

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
                              textt: displayText,
                              mrigth: 0,
                              icon: displayIcon,
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
