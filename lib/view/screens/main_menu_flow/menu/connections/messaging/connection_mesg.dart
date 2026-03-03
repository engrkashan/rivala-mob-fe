import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/chat_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/followers_manual_add.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/chats.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/new_messages.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class ConnectionMesg extends StatefulWidget {
  final bool? hasBack;
  const ConnectionMesg({super.key, this.hasBack = true});

  @override
  State<ConnectionMesg> createState() => _ConnectionMesgState();
}

class _ConnectionMesgState extends State<ConnectionMesg> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().getAllChats();
      context.read<ChatProvider>().loadUnreadMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Messages',
            centerTitle: true,
            haveBackButton: widget.hasBack ?? false,
            actions: widget.hasBack == false ? [] : null),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          contentvPad: 5,
                          hint: 'Search Conversations',
                          prefixIcon: Image.asset(
                            Assets.imagesSearch,
                            width: 12,
                          ),
                          marginBottom: 0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      circular_icon_container(
                        ontap: () {
                          Get.to(() => NewMessages());
                        },
                        icon: Assets.imagesMesg2,
                        size: 45,
                        iconSize: 22,
                      )
                    ],
                  ),
                  ////////
                  ///
                  SizedBox(
                    height: 23,
                  ),
                  Consumer<ChatProvider>(
                    builder: (context, provider, _) {
                      if (provider.allChats.isEmpty) {
                        return Center(
                          child: MyText(
                            text: "No new messages",
                            color: kblack.withOpacity(0.6),
                            size: 14,
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.allChats.length,
                        itemBuilder: (context, index) {
                          final msg = provider.allChats;
                          final unread =
                              provider.unreadChats?[msg[index].chatId] ?? 0;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: manual_add_row(
                              ontap: () {
                                Get.to(() => Chats(
                                    receiverId: msg[index].id,
                                    title: msg[index].name));
                              },
                              imageUrl: msg[index].avatarUrl,
                              text1: msg[index].name,
                              text2: msg[index].lastMessage ?? '',
                              name: msg[index].name,
                              color2: kblack,
                              color1: kblack,
                              size1: 15,
                              size2: 11,
                              isButton: false,
                              mbot: 4,
                              weight2: FontWeight.normal,
                              suffixWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (unread > 0)
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kgreen),
                                      child: Center(
                                          child: MyText(
                                        text: "$unread",
                                        color: kwhite,
                                      )),
                                    ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  MyText(
                                    text: formatChatTime(
                                        msg[index].lastMessageTime),
                                    size: 11,
                                    color: kblack.withOpacity(0.6),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }

  String formatChatTime(DateTime? time) {
    if (time == null) return "";

    final now = DateTime.now();
    final difference = now.difference(time);

    // Today
    if (difference.inDays == 0) {
      if (difference.inMinutes < 1) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} min ago";
      } else {
        return "${difference.inHours} hours ago";
      }
    }

    // Yesterday
    if (difference.inDays == 1) {
      return "Yesterday";
    }

    // Before yesterday → Day name
    return _dayName(time.weekday);
  }

  String _dayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
