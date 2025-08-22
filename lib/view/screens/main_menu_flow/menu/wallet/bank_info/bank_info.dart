import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class BankInfo extends StatefulWidget {

  final bool? newBank;
  final String? title;
  const BankInfo({super.key, this.newBank=false, this.title});

  @override
  State<BankInfo> createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,title:widget.title?? 'Zions Bank', centerTitle: true),
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
                  hint: '1234567890',
                  label: 'Account Number',
                  bordercolor: ktransparent,
                  filledColor: kgrey2,
                ),
                MyTextField(
                  label: 'Routing Number',
                  hint: '1234567890',
                  bordercolor: ktransparent,
                  filledColor: kgrey2,
                ),
                MyTextField(
                  hint: 'America First',
                  label: 'Bank Name',
                  bordercolor: ktransparent,
                  filledColor: kgrey2,
                ),
                if(widget.newBank==false)
                MyText(
                  text: 'Remove bank',
                  size: 15,
                  weight: FontWeight.w400,
                  color: kred,
                  paddingTop: 30,
                  paddingBottom: 15,
                ),
              ],
            ),
          ),
          MyButton(
            buttonText: 'Save bank',
            mBottom: 50,
            mhoriz: 22,
          )
        ],
      ),
    );
  }
}
