import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';

class dummyimgeStack extends StatelessWidget {
  final Widget? bodyWidget,buttonWidget;
  final String? buttonText;
  final VoidCallback? ontap;
  const dummyimgeStack({super.key, this.bodyWidget, this.buttonWidget, this.buttonText, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CommonImageView(
                    imagePath: Assets.imagesDummyimage2,
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            
          ],
        ),
    );
  }
}