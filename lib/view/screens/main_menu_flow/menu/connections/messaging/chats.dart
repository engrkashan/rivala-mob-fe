import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/new_messages.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class Chats extends StatefulWidget {
  final String? title;
  final bool? isGroup;
  const Chats({super.key, this.title, this.isGroup=false});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,centerTitle: true, title:widget.title?? 'Cy Tidwell'),
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
                  MyText(
                    text: 'Today at 7:49 PM',
                    color: kblack.withOpacity(0.6),
                    size: 13,
                    textAlign: TextAlign.center,
                    paddingBottom: 20,
                  ),
                  MessageTile(isSentBy: true, message: 'Hy, Cy'),
                  MessageTile(isSentBy: true, message: 'How’s your day going?'),
                    if(widget.isGroup==true)
                  MyText(text: 'Cy Tidwell',color: kblack.withOpacity(0.6),),
                  MessageTile(
                      isSentBy: false,
                      message:
                          'Pretty well'),
                  MessageTile(
                      isSentBy: false,
                      message: 'Just chilling'),
                      if(widget.isGroup==true)...{
                               MyText(text: 'Cy Tidwell',color: kblack.withOpacity(0.6),),
                  MessageTile(
                      isSentBy: false,
                      message:
                          'Pretty well'),
                  MessageTile(
                      isSentBy: false,
                      message: 'Just chilling'),
                      },
                  SizedBox(
                    height: 10,
                  )
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

//mesg tiles
class MessageTile extends StatelessWidget {
  final bool isSentBy;
  final String message;

  const MessageTile({Key? key, required this.isSentBy, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Column(
        crossAxisAlignment:
            isSentBy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSentBy ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // Conditionally place the avatar for sent messages on the right
              // if (!isSentBy) ...[
              //   Center(
              //       child: CommonImageView(
              //     url: dummyImage,
              //     fit: BoxFit.cover,
              //     width: 36,
              //     height: 36,
              //     radius: 36,
              //   )),
              //   SizedBox(width: 8),
              // ],

              // Message container
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Column(
                    crossAxisAlignment: isSentBy
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: isSentBy ? null : kgrey4,
                            gradient: isSentBy ? kgradmainmenu : null,
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: MyText(
                            text: message,
                            color: isSentBy ? kwhite : kblack,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Conditionally place the avatar for sent messages on the right
              // if (isSentBy) ...[
              //   SizedBox(width: 8),
              //   Center(
              //       child: CommonImageView(
              //     url: dummyImage,
              //     fit: BoxFit.cover,
              //     width: 36,
              //     height: 36,
              //     radius: 36,
              //   )),
              // ],
            ],
          ),
        ],
      ),
    );
  }
}
