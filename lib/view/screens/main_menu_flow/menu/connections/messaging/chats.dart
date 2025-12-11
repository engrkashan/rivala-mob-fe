import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/chat_provider.dart';
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
                      // Reverse index to show latest messages at the bottom if using reverse: true
                      // Or just map normally if backend returns oldest to newest and we want standard flow.
                      // Backend returns orderBy: { createdAt: "asc" } -> Oldest first.
                      // If we use reverse: true in ListView, we need newest first (desc).
                      // So let's reverse the list or use normal list view with controller to scroll to bottom.
                      // Standard practice: reverse list view and data sorted desc.

                      // For now, let's keep it simple. If we use reverse: true, item 0 is at bottom.
                      // If key is to scroll to bottom, reverse: true is better.
                      // So we need to access items from end to start.
                      final reversedIndex = provider.chats.length - 1 - index;
                      final msg = provider.chats[reversedIndex];

                      // senderId for current user. We assume we have it or can check against message sender.
                      // Actually provider doesn't have current user ID easily accessible unless we store it or decode token.
                      // But the backend says: senderId = req.user.id.
                      // In message model: senderId is returned.
                      // We need to know "my" id to determine isSentBy.
                      // Let's assume we can't easily get it here without another call or storage.
                      // Wait, msg.senderId == widget.receiverId ? false : true -> if sender is receiver, then it is NOT sent by me.
                      // so isSentBy = msg.senderId != widget.receiverId?
                      // If msg.senderId is ME, then it is NOT receiverId.
                      // Correct.

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
                  context
                      .read<ChatProvider>()
                      .sendMessage(_controller.text, widget.receiverId);
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

// Placeholder for the text field widget if not imported or needs modification
// Attempting to use existing one but likely need to modify it to accept controller/callback.
// Check if 'chats_textfield' is a class defined elsewhere or just below (it wasn't in the file view).
// It was imported: import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/new_messages.dart';
// I should probably check that file too.
// For now, I'll assume I can pass arguments, but if it's stateless static, I might need to wrap or modify it.
// Actually, looking at the original file: 
// 69:               child: chats_textfield(),
// It's likely a widget in 'new_messages.dart' or similar.

