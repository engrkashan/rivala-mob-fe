import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/font_customisation/font_customization.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';

class ViewAddedProduct extends StatefulWidget {
  const ViewAddedProduct({super.key});

  @override
  State<ViewAddedProduct> createState() =>
      _ViewAddedProductState();
}

class _ViewAddedProductState extends State<ViewAddedProduct> {
    final FontController fontController = Get.find<FontController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: image_appbar(),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomeContainer(
                  height: 360,
                  color: kwhite,
                  hpad: 0,
                  vpad: 0,
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: 
                        ContainerAppbar(title: 'Add product to my storefront',isCenter: false,)
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                  
                      Center(child: Image.asset(Assets.imagesRivalalogo,height: 30,width: 113,)),
                      MyText(
                        text: 'To add this product to your storefront, please create a Rivala account.',
                        size: 14,
                        color: kheader, //kter
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingRight: 18,
                        textAlign: TextAlign.center,
                        paddingBottom: 30,
                        paddingTop: 25,
                         useCustomFont: true,
                      ),
                  Center(
                    child: Obx(() => Text(
        'Log in'  ,
          style: TextStyle(
            fontSize: 16,
            fontFamily: fontController.selectedFont.value.isEmpty
                ? AppFonts.poppins
                : fontController.selectedFont.value,
            color: Colors.transparent,
            decoration: TextDecoration.underline,
            decorationColor: ktertiary,
            decorationThickness: 1,
            decorationStyle: TextDecorationStyle.solid,
            height: 1.4, // Adjusts spacing between text and underline
            shadows: [
              Shadow(color: ktertiary, offset: Offset(0, -3)),
            ],
          ),
          textAlign: TextAlign.center,
        ))
                  ),
                      Spacer(),
                      CustomeContainer(
                        hasShadow: true,
                        color: kwhite,
                        radius: 50,
                        widget: MyButton(
                          fontColor: kwhite, //buttoncolor
                          onTap: () {
                          //  Get.to(() => AddProductInstore());
                          },
                          buttonText: 'Create my Rivala account',
                           useCustomFont: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
