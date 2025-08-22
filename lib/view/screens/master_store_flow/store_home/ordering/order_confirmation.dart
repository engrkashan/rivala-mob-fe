import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({super.key});

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
        ),
        ImageLayoutWidget(
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ContainerAppbar(title: 'Confirm Order'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: kgrey2),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                  child: Image.asset(
                Assets.imagesCheckmark,
                width: 80,
                height: 80,
              )),
              Center(
                  child: MyText(
                text: 'Confirm Order',
                size: 20,
                color: kgreen,
                weight: FontWeight.w600,
                 useCustomFont: true,
              )),
              Center(
                  child: MyText(
                text:
                    'A confirmation email with your order details was sent to',
                size: 14,
                color: kbody,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
                paddingLeft: 18,
                paddingRight: 18,
                 useCustomFont: true,
              )),
                 Center(
                  child: MyText(
                text:
                    'janesmith@gmail.com',
                size: 14,
                color: kbody,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
                 useCustomFont: true,
                // paddingLeft: 18,
                // paddingRight: 18,
                decoration: TextDecoration.underline
              )),
            ],
          ),
          button2: true,
        )
      ],
    );
  }
}
