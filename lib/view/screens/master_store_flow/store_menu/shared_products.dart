import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class SharedProducts extends StatefulWidget {
  const SharedProducts({super.key});

  @override
  State<SharedProducts> createState() => _SharedProductsState();
}

class _SharedProductsState extends State<SharedProducts> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderImageStack(showContent: false),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: TwoTextedColumn(
                text1: 'Here are the People Who Think We’re Cool',
                text2:
                    'We like showing off our friends and family. Here are some of their greatest hits!',
                color1: kheader,
                color2: kbody,
                weight1: FontWeight.w600,
                size1: 18,
                size2: 14,
                useCustomFont: true,
              ),
            ),

    
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
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

            const SizedBox(height: 30),
            StoreFotter(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,bottom: 90),
        child: Store_Button_Row(),
      ),
    );
  }
}
