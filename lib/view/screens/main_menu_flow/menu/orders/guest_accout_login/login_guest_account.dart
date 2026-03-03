import 'dart:io';

import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';

import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/my_orders.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/order_detail_view.dart';
import 'package:get/get.dart';

class LoginGuestAccount extends StatefulWidget {
  const LoginGuestAccount({super.key});

  @override
  State<LoginGuestAccount> createState() => _LoginGuestAccountState();
}

class _LoginGuestAccountState extends State<LoginGuestAccount> {
  int selectedIndex = -1; // -1 means no selection
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orderNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleTrackRequest() async {
    if (_formKey.currentState?.validate() ?? false) {
      final searchValue = selectedIndex == 0
          ? _emailController.text.trim()
          : _orderNumberController.text.trim();

      final provider = context.read<OrderProvider>();
      final order = await provider.trackOrder(orderNumber: searchValue);

      if (order != null) {
        Navigator.of(context).push(
          CustomPageRoute(page: OrderDetailView(order: order)),
        );
      } else {
        AlertInfo.show(
          context: context,
          text:
              "Could not find an order with that ${selectedIndex == 0 ? 'email' : 'ID'}.",
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _orderNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: '',
        onCloseIconTap: () {
          if (selectedIndex != -1) {
            setState(() {
              selectedIndex = -1;
            });
          } else {
            Get.back();
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Image.asset(
                    Assets.imagesLogo1,
                    width: 76,
                    height: 64,
                  ),
                  MyText(
                    text: 'Do you have...',
                    size: 24,
                    color: kblack,
                    weight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    paddingTop: 10,
                    paddingBottom: 20,
                  ),
                  SizedBox(
                    height: 94,
                    child: Row(
                      children: [
                        Expanded(
                          child: guest_login_container(
                            isSelected: selectedIndex == 0,
                            ontap: () {
                              setState(() {
                                selectedIndex = (selectedIndex == 0) ? -1 : 0;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: guest_login_container(
                            title: 'Your order number?',
                            img: Assets.imagesOrdernumb,
                            lineHeight: 1,
                            isSelected: selectedIndex == 1,
                            ontap: () {
                              setState(() {
                                selectedIndex = (selectedIndex == 1) ? -1 : 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///statechanging hadleing
                  if (selectedIndex == 0) ...{
                    SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                      controller: _emailController,
                      hint: 'Enter email',
                      label: 'Email',
                      bordercolor: ktransparent,
                      filledColor: kblack.withOpacity(0.06),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(val)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    )
                  },
                  if (selectedIndex == 1) ...{
                    SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                      controller: _orderNumberController,
                      hint: 'Enter Order Number',
                      label: 'Order Number',
                      bordercolor: ktransparent,
                      filledColor: kblack.withOpacity(0.06),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Order number is required";
                        }
                        return null;
                      },
                    )
                  }
                ],
              ),
            ),
            if (selectedIndex == 0 || selectedIndex == 1)
              MyButton(
                buttonText: 'Check Order',
                mhoriz: 22,
                mBottom: Platform.isIOS ? 140 : 120, //120,
                onTap: _handleTrackRequest,
              )
          ],
        ),
      ),
    );
  }
}

class guest_login_container extends StatelessWidget {
  final String? title, img;
  final bool? isSelected;
  final double? lineHeight;
  final VoidCallback? ontap;
  const guest_login_container({
    super.key,
    this.title,
    this.img,
    this.isSelected,
    this.ontap,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: CustomeContainer(
        borderWidth: 2,
        borderColor: kgreen2,
        color: isSelected == true ? kgreen2 : ktransparent,
        radius: 8,
        vpad: 6,
        hpad: 6,
        widget: Column(
          children: [
            Image.asset(
              img ?? Assets.imagesEmail,
              width: 32,
              height: 32,
              color: isSelected == true ? kwhite : null,
            ),
            MyText(
              text: title ?? 'Your email?',
              size: 20,
              color: isSelected == true ? kwhite : kblack,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
              lineHeight: lineHeight,
            )
          ],
        ),
      ),
    );
  }
}
