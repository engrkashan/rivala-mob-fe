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
import 'package:rivala/view/widgets/switch_button.dart';

class PaymentDetail extends StatefulWidget {
  final bool? newBank;
  final String? title;
  final PaymentMethodModel? model;

  const PaymentDetail({
    super.key,
    this.newBank = false,
    this.title,
    this.model,
  });

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  final _formKey = GlobalKey<FormState>();

  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();
  final expMonth = TextEditingController();
  final expYear = TextEditingController();
  final cvc = TextEditingController();

  bool setAsDefault = true;

  @override
  void dispose() {
    cardHolderName.dispose();
    cardNumber.dispose();
    expMonth.dispose();
    expYear.dispose();
    cvc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.model != null) {
          cardHolderName.text = widget.model!.cardholderName!;
          cardNumber.text = widget.model!.cardNumber!;
          cvc.text = widget.model!.cvc!;
          expYear.text = widget.model!.expirationDate!.split('/')[1];
          expMonth.text = widget.model!.expirationDate!.split('/')[0];
          setAsDefault = widget.model!.isDefault!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: widget.title ?? 'Payment Details',
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 30),

                  /// Card Holder Name
                  MyTextField(
                    controller: cardHolderName,
                    hint: 'Austin Larsen',
                    label: 'Name on Card',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name on card is required';
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Enter a valid name';
                      }
                      return null;
                    },
                  ),

                  /// Card Number
                  MyTextField(
                    controller: cardNumber,
                    label: 'Card Number',
                    hint: '1234 5678 9012 3456',
                    keyboardType: TextInputType.number,
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Card number is required';
                      }
                      if (!RegExp(r'^\d{13,19}$').hasMatch(value)) {
                        return 'Enter a valid card number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  /// Expiry Date
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: expMonth,
                          hint: 'MM',
                          label: 'Month',
                          keyboardType: TextInputType.number,
                          bordercolor: ktransparent,
                          filledColor: kgrey2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Month required';
                            }
                            final month = int.tryParse(value);
                            if (month == null || month < 1 || month > 12) {
                              return 'Invalid month';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MyTextField(
                          controller: expYear,
                          hint: 'YY',
                          label: 'Year',
                          keyboardType: TextInputType.number,
                          bordercolor: ktransparent,
                          filledColor: kgrey2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Year required';
                            }

                            final inputYear = int.tryParse(value);
                            if (inputYear == null ||
                                inputYear < 0 ||
                                inputYear > 99) {
                              return 'Invalid year';
                            }

                            final currentYear = DateTime.now().year % 100;

                            if (inputYear < currentYear) {
                              return 'Card expired';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// CVC
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: cvc,
                          hint: 'CVC',
                          label: 'CVC',
                          keyboardType: TextInputType.number,
                          bordercolor: ktransparent,
                          filledColor: kgrey2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CVC required';
                            }
                            if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
                              return 'Invalid CVC';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 200),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Set Default
                  Row(
                    children: [
                      SwitchButton(
                        isActive: setAsDefault,
                        onChanged: (value) {
                          setState(() {
                            setAsDefault = value;
                          });
                        },
                      ),
                      MyText(
                        paddingLeft: 5,
                        text: 'Set as Default',
                        size: 15,
                        weight: FontWeight.w500,
                        color: kblack,
                      ),
                    ],
                  ),
                  if (!widget.newBank!)

                    /// Remove Payment
                    context.read<PaymentMethodsProvider>().isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () async {
                              final payment =
                                  context.read<PaymentMethodsProvider>();
                              await payment
                                  .deletPaymentMethod(widget.model!.id!);
                              if (payment.error != null) {
                                AlertInfo.show(
                                    context: context, text: payment.error!);
                                return;
                              }
                              Navigator.pop(context);
                            },
                            child: MyText(
                              text: 'Remove payment',
                              size: 15,
                              weight: FontWeight.w400,
                              color: kred,
                              paddingTop: 30,
                              paddingBottom: 15,
                            ),
                          ),
                ],
              ),
            ),

            /// SAVE BUTTON (example trigger)
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: context.read<PaymentMethodsProvider>().isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final name = cardHolderName.text.trim();
                            final number = cardNumber.text.trim();
                            final expDate =
                                "${expMonth.text.trim()}/${expYear.text.trim()}";
                            final cvcc = cvc.text.trim();
                            final isDefault = setAsDefault;

                            final data = {
                              "cardholderName": name,
                              "cardNumber": number,
                              "expirationDate": expDate,
                              "cvc": cvcc,
                              "isDefault": isDefault
                            };

                            final payment =
                                context.read<PaymentMethodsProvider>();
                            if (widget.newBank!) {
                              await payment.addPaymentMethod(data, "card");
                            } else {
                              await payment.updatePaymentMethod(
                                  data, "card", widget.model!.id!);
                            }
                            if (payment.error != null) {
                              AlertInfo.show(
                                  context: context, text: payment.error!);
                              return;
                            }
                            Navigator.pop(context);
                          }
                        },
                        buttonText: !widget.newBank!
                            ? "Update Payment"
                            : "Save Payment",
                      )),
          ],
        ),
      ),
    );
  }
}
