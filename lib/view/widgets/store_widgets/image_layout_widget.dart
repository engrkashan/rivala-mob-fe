import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';

class ImageLayoutWidget extends StatelessWidget {
  final Widget? bodyWidget, buttonWidget;
  final double? vpad;
  final String? buttonText;
  final VoidCallback? ontap;
  final bool? button2;
  const ImageLayoutWidget(
      {super.key,
      this.bodyWidget,
      this.buttonWidget,
      this.buttonText,
      this.ontap,
      this.vpad,
      this.button2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: image_appbar(),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: vpad ?? 0),
            decoration: BoxDecoration(
                color: kwhite, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    //   margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: kwhite, borderRadius: BorderRadius.circular(15)),
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(), child: bodyWidget),
                  ),
                ),
                if (buttonText != null)
                  Mybutton2(
                    useCustomFont: true,
                    buttonText: buttonText ?? 'Checkout',
                    ontap: ontap ?? () {},
                  ),
                if (button2 == true)
                  CustomeContainer(
                    color: kwhite,
                    hasShadow: true,
                    radius: 50,
                    widget: Column(
                      children: [
                        MyButton(
                          outlineColor: kbutton,
                          backgroundColor: kwhite,
                          fontColor: kbutton,
                          buttonText: 'Keep shopping',
                          useCustomFont: true,
                          onTap: () {
                            Get.to(() => CollectionGrid());
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          buttonText: 'See your order',
                          useCustomFont: true,
                          onTap: () {},
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
