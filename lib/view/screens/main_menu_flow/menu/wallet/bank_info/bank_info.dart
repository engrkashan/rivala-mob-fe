import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/payment_methods_provider.dart';
import 'package:rivala/models/payment_method_model.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class BankInfo extends StatefulWidget {
  final bool? newBank;
  final String? title;
  final PaymentMethodModel? bank;
  const BankInfo({super.key, this.newBank = false, this.title, this.bank});

  @override
  State<BankInfo> createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  final accountNumber = TextEditingController();
  final routingNumber = TextEditingController();
  final bankName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context,
          title: widget.title ?? 'Zions Bank',
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 30),
                  MyTextField(
                    controller: accountNumber,
                    hint: '1234567890',
                    label: 'Account Number',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Account Number is required';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                        return 'Account Number must be numeric';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: routingNumber,
                    hint: '1234567890',
                    label: 'Routing Number',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Routing Number is required';
                      }
                      if (!RegExp(r'^\d{9}$').hasMatch(value.trim())) {
                        return 'Routing Number must be 9 digits';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: bankName,
                    hint: 'America First',
                    label: 'Bank Name',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Bank Name is required';
                      }
                      return null;
                    },
                  ),
                  if (widget.newBank == false)
                    MyText(
                      text: 'Remove bank',
                      size: 15,
                      weight: FontWeight.w400,
                      color: kred,
                      paddingTop: 30,
                      paddingBottom: 15,
                      onTap: () async {
                        await context
                            .read<PaymentMethodsProvider>()
                            .deletPaymentMethod(widget.bank!.id ?? "");
                        if (context.read<PaymentMethodsProvider>().error !=
                            null) {
                          AlertInfo.show(
                              context: context,
                              text: context
                                  .read<PaymentMethodsProvider>()
                                  .error!);
                          return;
                        }
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
          ),
          context.watch<PaymentMethodsProvider>().isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MyButton(
                  buttonText:
                      widget.newBank == true ? 'Save bank' : 'Update Bank',
                  mBottom: 50,
                  mhoriz: 22,
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final account = accountNumber.text.trim();
                    final routing = routingNumber.text.trim();
                    final bank = bankName.text.trim();

                    final data = {
                      "accountNumber": account,
                      "routingNumber": routing,
                      "bankName": bank
                    };

                    final payment = context.read<PaymentMethodsProvider>();

                    if (widget.newBank == true) {
                      await payment.addPaymentMethod(data, "bank");
                    } else {
                      await payment.updatePaymentMethod(
                          data, "bank", widget.bank!.id!);
                    }

                    if (payment.error != null) {
                      AlertInfo.show(context: context, text: payment.error!);
                      return;
                    }

                    Navigator.pop(context);
                  },
                ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.bank != null) {
      accountNumber.text = widget.bank!.accountNumber!;
      routingNumber.text = widget.bank!.routingNumber!;
      bankName.text = widget.bank!.bankName!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    accountNumber.dispose();
    routingNumber.dispose();
    bankName.dispose();
  }
}
