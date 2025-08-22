import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/tag_collection/tag_collection.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Add location',
            centerTitle: true,
            actions: [
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose,
                    width: 18,
                    height: 18,
                  )),
              SizedBox(
                width: 12,
              )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kgrey2,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: MyTextField(
                      radius: 50,
                      filledColor: kgrey4,
                      hint: 'Search locations . . .',
                      bordercolor: ktransparent,
                      suffixIcon: Image.asset(
                        Assets.imagesSearch,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, switchIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: icon_text_row(
                          hasIcon: false,
                          title: 'Seaport Village, CA',
                          textSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Mybutton2(
              buttonText2: 'Cancel',
              buttonText: 'Done',
              mbot: 30,
              hpad: 22,
              ontap: () {
                Get.back();
              },
              ontap2: () {
                Get.back();
              },
            )
          ],
        ));
  }
}
