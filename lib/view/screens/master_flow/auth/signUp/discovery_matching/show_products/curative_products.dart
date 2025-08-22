import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CurativeProducts extends StatefulWidget {
  const CurativeProducts({super.key});

  @override
  State<CurativeProducts> createState() => _CurativeProductsState();
}

class _CurativeProductsState extends State<CurativeProducts> {
    final List<String> products = [
    Assets.imagesProduct2,
    Assets.imagesProduct3,
    Assets.imagesEcuador,
    Assets.imagesProduct2,
    Assets.imagesProduct3,
    Assets.imagesEcuador,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: ListView(
                  children: [
                    MyText(
                      paddingTop: 25,
                      text: 'Take a look at these products!',
                      size: 24,
                      color: kblack2,
                      weight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      paddingBottom: 20,
                    ),
                      GridView.builder(
            //  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true, 
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                mainAxisExtent: 100, 
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CommonImageView(
                    imagePath: products[index], 
                    width: 135,
                    height: 135,
                 //   fit: BoxFit.contain,
                    radius: 10,
                  ),
                );
              },
            ),

                  ],
                )),
          ),
        ],
      ),
    );
  }
}
