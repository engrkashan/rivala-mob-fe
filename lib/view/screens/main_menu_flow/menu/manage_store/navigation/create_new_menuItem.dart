import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/navigation/add_new_section.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class CreateNewMenuitem extends StatefulWidget {
  final bool? hasItems;
  const CreateNewMenuitem({super.key, this.hasItems=false});

  @override
  State<CreateNewMenuitem> createState() => _CreateNewMenuitemState();
}

class _CreateNewMenuitemState extends State<CreateNewMenuitem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar:
          simpleAppBar(context: context,title: 'Add Menu Section', centerTitle: true, size: 18),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                MyTextField(
                  label: 'Section Name',
                  hint: 'Our Fall Favorites',
                  bordercolor: ktransparent,
                  filledColor: kgrey2,
                ),
                MyText(
                  text: 'Sub-menu',
                  size: 15,
                  weight: FontWeight.w500,
                  color: kblack,
                  paddingBottom: 10,
                  paddingTop: 10,
                ),
           
               
             if(widget.hasItems==true)   
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child:                 Row(children: [
                store_image_stack(
                    width: 45,
                    height: 45,
                    iconSize: 12,
                    radius: 8,
                    showContent: false,
                    showShadow: false,
                    icon: Assets.imagesCollection4,
                  ),
                    MyText(text: 'Womens',size: 15,weight: FontWeight.w500,color: kblack,paddingLeft: 8,),
                ],),
                    );
                  },
                ),

     MyText(
                  text: '+ Add sub-menu',
                  size: 12,
                  weight: FontWeight.w500,
                  color: kblue,
                  onTap: () {
                    Get.bottomSheet(AddNewSection(),isScrollControlled: true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: MyButton(
        buttonText:widget.hasItems==true?'Save section': 'Create new section',
        mhoriz: 22,
        mBottom: 40,
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
