import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

class PaymentDetail extends StatefulWidget {
  final bool? newBank;
  final String? title;
  const PaymentDetail({super.key, this.newBank = false, this.title});

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,
          title: widget.title ?? 'Payment Details', centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 30),
                MyTextField(
                  hint: 'Austin Larsen',
                  label: 'Name on Card',
                  bordercolor: ktransparent,
                  filledColor: kgrey2,
                ),
                MyTextField(
                  label: 'Card Number',
                  hint: '1234567890',
                  bordercolor: ktransparent,
                  filledColor: kgrey2,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        hint: 'April',
                        label: 'Month',
                        bordercolor: ktransparent,
                        filledColor: kgrey2,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MyTextField(
                        hint: '2034',
                        label: 'Year',
                        bordercolor: ktransparent,
                        filledColor: kgrey2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        hint: '3245',
                        label: 'CVC',
                        bordercolor: ktransparent,
                        filledColor: kgrey2,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SwitchButton(
                      isActive: true,
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
                MyText(
                  text: 'Remove payment',
                  size: 15,
                  weight: FontWeight.w400,
                  color: kred,
                  paddingTop: 30,
                  paddingBottom: 15,
                ),
              ],
            ),
          ),
          // MyButton(
          //   buttonText: 'Save bank',
          //   mBottom: 50,
          //   mhoriz: 22,
          // )
        ],
      ),
    );
  }
}
