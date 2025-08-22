import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class MultipleProductPostVeiw extends StatefulWidget {
  const MultipleProductPostVeiw({super.key});

  @override
  State<MultipleProductPostVeiw> createState() =>
      _MultipleProductPostVeiwState();
}

class _MultipleProductPostVeiwState extends State<MultipleProductPostVeiw> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      dummyimgeStack(),
      Scaffold(
          backgroundColor: ktransparent,
          body: ImageLayoutWidget(
              bodyWidget: Column(children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ContainerAppbar(
                title: 'Summer Fun Collection',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: kgrey2,
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 260),
              itemBuilder: (context, index) {
                return store_image_stack(
                  height: 200,
                  singlePrice: true,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Mybutton2(
              buttonText: 'Back',
              ontap: () {
                    Get.back();
              },
              useCustomFont: true,
              bgColor: kwhite,
              borderColor: kbutton,
              fontColor: kbutton,
            )
          ])))
    ]);
  }
}
