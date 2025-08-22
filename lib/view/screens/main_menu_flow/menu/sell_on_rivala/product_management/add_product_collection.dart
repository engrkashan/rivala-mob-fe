import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddProductCollection extends StatelessWidget {
  const AddProductCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
    
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: kwhite),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                        ContainerAppbar(
                  title: 'New Collection',
                  textColor: kblack,
                  icon: Assets.imagesClose2,
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hint: 'Size',
                  label: 'Collection Name',
                ),
                  MyTextField(
                  hint: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                  label: 'Collection Description',
                  maxLines: 4,
                ),  MyText(
                  text: '+ Add Product to Collection',
                  color: kblue,
                  weight: FontWeight.w500,
                  size: 12,
                  paddingBottom: 30,
                  paddingTop: 20,
                ),
                MyButton(
                  buttonText: 'Save collection',
                  mBottom: 30,
                )
                  ],
              ))));
  }
}