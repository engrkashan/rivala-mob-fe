import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class CreateNewPage extends StatelessWidget {
  const CreateNewPage({super.key});

  @override
  Widget build(BuildContext context) {
        return Container(
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
                title: 'Create a New Page',
                icon: Assets.imagesClose2,
                textColor: kblack,
              ),
              SizedBox(
                height: 20,
              ),

              MyTextField(
                hint: 'Type page name here',
                label: 'Page Name',
              ),
              SizedBox(height: 20,),
              MyButton(buttonText: 'Create page',mBottom: 40,)
            ],
          )));
  }
}