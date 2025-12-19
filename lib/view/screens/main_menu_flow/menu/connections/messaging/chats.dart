import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/chat_provider.dart';
import 'package:rivala/controllers/providers/user/auth_provider.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/chat_text_field.dart';

class Chats extends StatefulWidget {
  final String? title;
  final String receiverId;
  final bool? isGroup;
  const Chats(
      {super.key, this.title, required this.receiverId, this.isGroup = false});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            centerTitle: true,
            title: widget.title ?? 'Cy Tidwell'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.chats.isEmpty) {
                    return Center(child: MyText(text: "No messages yet"));
                  }
                  return ListView.builder(
                    reverse: true, // Typically chat starts from bottom
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 22),
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.chats.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = provider.chats.length - 1 - index;
                      final msg = provider.chats[reversedIndex];
                      return MessageTile(
                        isSentBy: msg.senderId != widget.receiverId,
                        message: msg.content ?? "",
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
              child: ChatsTextField(
                controller: _controller,
                onSend: () {
                  final userId = context.read<AuthProvider>().currentUserId;
                  context
                      .read<ChatProvider>()
                      .sendMessage(_controller.text, widget.receiverId, userId);
                  _controller.clear();
                },
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().loadMessages(widget.receiverId);
    });
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
            ],
          ),
        ],
      ),
    );
  }
}
