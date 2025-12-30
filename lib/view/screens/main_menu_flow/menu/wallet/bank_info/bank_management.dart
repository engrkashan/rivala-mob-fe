import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/payment_methods_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/bank_info/bank_info.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class BankManagement extends StatefulWidget {
  const BankManagement({super.key});

  @override
  State<BankManagement> createState() => _BankManagementState();
}

class _BankManagementState extends State<BankManagement> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final payment = context.read<PaymentMethodsProvider>();
      await payment.loadPaymentMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: 'Bank Management',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Banks List
            Consumer<PaymentMethodsProvider>(
              builder: (context, payment, _) {
                final banks = payment.paymentMethods
                        ?.where((e) => e.type == "BANK")
                        .toList() ??
                    [];

                if (banks.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: MyText(
                        text: 'No banks added yet',
                        size: 16,
                        weight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true, // crucial
                  physics:
                      const NeverScrollableScrollPhysics(), // avoid scroll conflict
                  itemCount: banks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    return ShoppingRow(
                      ontap: () => Get.to(() => BankInfo(bank: banks[i])),
                      isSelected: false,
                      mleft: 0,
                      justIcon: true,
                      weight: FontWeight.w500,
                      textt: banks[i].bankName,
                      mrigth: 0,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 35),

            /// Alternative Accounts
            MyText(
              text: 'Alternative Accounts',
              size: 15,
              weight: FontWeight.w600,
              color: kblack,
              paddingBottom: 15,
            ),
            alternative_account_row(),
            const SizedBox(height: 15),
            alternative_account_row(
              hint: 'paypal.me/austin',
              icon: Assets.imagesPaypal2,
            ),
            const SizedBox(height: 15),
            alternative_account_row(
              hint: 'Manually add link',
              icon: Assets.imagesAddmore,
            ),

            /// Connect New Bank
            const SizedBox(height: 35),
            MyText(
              text: '+ Connect new bank',
              size: 15,
              weight: FontWeight.w400,
              color: kblue,
              onTap: () {
                Get.to(() => BankInfo(
                      newBank: true,
                      title: 'New Bank',
                    ));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// Alternative account row
class alternative_account_row extends StatelessWidget {
  final String? hint, icon;
  const alternative_account_row({super.key, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon ?? Assets.imagesVenmo,
          width: 44,
          height: 44,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MyTextField(
            hint: hint ?? 'Venmo.me/austin',
            radius: 50,
            bordercolor: kgrey2,
            marginBottom: 0,
            delay: 0,
          ),
        ),
      ],
    );
  }
}
