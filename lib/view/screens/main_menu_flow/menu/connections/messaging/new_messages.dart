import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,centerTitle: true, title: 'New Message'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kgrey2,
            ),
            MyTextField(
              hint: '      To: Search your contacts...',
              radius: 0,
              bordercolor: ktransparent,
              marginBottom: 0,
            ),
            Divider(
              color: kgrey2,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Bounce_widget(
                            ontap: () {
                              // Get.to(()=>Chats());
                            },
                            widget: Row(
                              children: [
                                CommonImageView(
                                  imagePath: Assets.imagesUser,
                                  width: 30,
                                  height: 30,
                                  radius: 100,
                                ),
                                MyText(
                                  text: 'Cy Tidwell',
                                  size: 15,
                                  paddingLeft: 10,
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                 
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
              child: chats_textfield(),
            ),
          ],
        ));
  }
}

class chats_textfield extends StatelessWidget {
  const chats_textfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kgrey4,
          blurRadius: 2,
          spreadRadius: 2,
          offset: Offset(0, 2),
        ),
      ], borderRadius: BorderRadius.circular(18)),
      child: MyTextField(
        hint: 'Message',
        filledColor: kwhite,
        bordercolor: ktransparent,
        marginBottom: 0,
        suffixIcon: SizedBox(
          // height: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    Assets.imagesMic,
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    Assets.imagesGallery,
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    Assets.imagesCamera,
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

