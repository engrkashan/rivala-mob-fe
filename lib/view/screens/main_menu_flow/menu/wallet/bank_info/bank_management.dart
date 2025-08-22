import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Bank Management', centerTitle: true),
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
                  ShoppingRow(
                    ontap: () {
                      Get.to(()=>BankInfo());
                    },
                    isSelected: false,
                    mleft: 0,
                    justIcon: true,
                    weight: FontWeight.w500,
                    textt: 'Zions Bank',
                    mrigth: 0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ShoppingRow(
                       ontap: () {
                      Get.to(()=>BankInfo());
                    },
                    isSelected: false,
                    mleft: 0,
                    justIcon: true,
                    weight: FontWeight.w500,
                    textt: 'America First Credit Union',
                    mrigth: 0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ShoppingRow(
                       ontap: () {
                      Get.to(()=>BankInfo());
                    },
                    isSelected: false,
                    mleft: 0,
                    justIcon: true,
                    weight: FontWeight.w500,
                    textt: 'Chase Bank',
                    mrigth: 0,
                  ),
                  MyText(
                    text: 'Alternative Accounts',
                    size: 15,
                    weight: FontWeight.w600,
                    color: kblack,
                    paddingTop: 35,
                    paddingBottom: 25,
                  ),
                  alternative_account_row(),
                  SizedBox(
                    height: 15,
                  ),
                  alternative_account_row(
                    hint: 'paypal.me/austin',
                    icon: Assets.imagesPaypal2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  alternative_account_row(
                    hint: 'Manually add link',
                    icon: Assets.imagesAddmore,
                  ),
                      MyText(
                    text: '+ Connect new bank',
                    size: 15,
                    weight: FontWeight.w400,
                    color: kblue,
                    paddingTop: 35,
                    paddingBottom: 15,
                          onTap: () {
                      Get.to(()=>BankInfo(
                        newBank: true,
                        title: 'New Bank',
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class alternative_account_row extends StatelessWidget {
  final String? hint, icon;
  const alternative_account_row({
    super.key,
    this.hint,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon ?? Assets.imagesVenmo,
          width: 44,
          height: 44,
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
            child: MyTextField(
          hint: hint ?? 'Venmo.me/austin',
          radius: 50,
          bordercolor: kgrey2,
          marginBottom: 0,
          delay: 0,
        ))
      ],
    );
  }
}
