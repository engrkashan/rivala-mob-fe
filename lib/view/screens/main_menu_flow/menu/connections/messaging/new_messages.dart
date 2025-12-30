import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/follow_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/chats.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FollowProvider>().loadFollowings();
    });
  }

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
              child: Consumer<FollowProvider>(
                builder: (context, ref, _) {
                  if (ref.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (ref.following.isEmpty) {
                    return Center(child: MyText(text: "No contacts found"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 22),
                    physics: const BouncingScrollPhysics(),
                    itemCount: ref.followers.length,
                    itemBuilder: (context, index) {
                      final follower = ref.followers[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Bounce_widget(
                            ontap: () {
                              Get.to(() => Chats(
                                  receiverId: follower.id ?? "",
                                  title: follower.name));
                            },
                            widget: Row(
                              children: [
                                CommonImageView(
                                  url: follower.logo,
                                  width: 30,
                                  height: 30,
                                  radius: 100,
                                ),
                                MyText(
                                  text: follower.name ?? "",
                                  size: 15,
                                  paddingLeft: 10,
                                )
                              ],
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
