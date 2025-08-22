import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class ProductsAddedSuccess extends StatefulWidget {
  const ProductsAddedSuccess({super.key});

  @override
  State<ProductsAddedSuccess> createState() => _ProductsAddedSuccessState();
}

class _ProductsAddedSuccessState extends State<ProductsAddedSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,title: 'Product Management', centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesCheckmark,
            width: 80,
            height: 80,
          ),
          Center(
            child: MyText(
              text: 'Products have been added!',
              size: 22,
              color: kgreen,
              weight: FontWeight.w600,
              textAlign: TextAlign.center,
              paddingTop: 10,
              paddingLeft: 22,
              paddingRight: 22,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyButton(
        mBottom: 60,
        buttonText: 'Return to product management',
        mhoriz: 22,
      ),
    );
  }
}
