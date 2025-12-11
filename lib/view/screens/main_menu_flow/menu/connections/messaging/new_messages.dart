import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/chats.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/chat_text_field.dart';

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
        appBar: simpleAppBar(
            context: context, centerTitle: true, title: 'New Message'),
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
                              Get.to(() => Chats(receiverId: "dummy_id"));
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
              child: ChatsTextField(),
            ),
          ],
        ));
  }
}
