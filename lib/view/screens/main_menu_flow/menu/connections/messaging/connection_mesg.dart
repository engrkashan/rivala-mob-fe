import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/chat_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/chats.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/new_messages.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class ConnectionMesg extends StatefulWidget {
  final bool? hasBack;
  const ConnectionMesg({super.key, this.hasBack = true});

  @override
  State<ConnectionMesg> createState() => _ConnectionMesgState();
}

class _ConnectionMesgState extends State<ConnectionMesg> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = context.read<ChatProvider>();
      provider.getAllChats();
      provider.loadUnreadMessages();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 1) return 'Now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inDays == 0) {
      final h = time.hour.toString().padLeft(2, '0');
      final m = time.minute.toString().padLeft(2, '0');
      return '$h:$m';
    }
    if (diff.inDays == 1) return 'Yesterday';
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[time.weekday - 1];
  }

  void _openNewMessage() {
    Navigator.of(context).push(CustomPageRoute(page: const NewMessages()));
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
        actions: widget.hasBack == false ? [] : null,
      ),
      body: Column(
        children: [
          // ── Search + New message button ──────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: _searchController,
                    contentvPad: 5,
                    hint: 'Search Conversations',
                    prefixIcon: Image.asset(Assets.imagesSearch, width: 12),
                    marginBottom: 0,
                    onChanged: (val) {
                      context.read<ChatProvider>().searchChats(val);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                circular_icon_container(
                  ontap: _openNewMessage,
                  icon: Assets.imagesMesg2,
                  size: 45,
                  iconSize: 22,
                ),
              ],
            ),
          ),

          // ── Conversations list ───────────────────────────────────────
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, provider, _) {
                // Loading shimmer
                if (provider.isLoading && provider.allChats.isEmpty) {
                  return _buildSkeleton();
                }

                final chats = provider.filteredChats;

                // Empty state — matches web's "No messages yet" + CTA
                if (chats.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: kwhite,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: Icon(Icons.chat_bubble_outline_rounded,
                                size: 50, color: kblue2),
                          ),
                          const SizedBox(height: 20),
                          MyText(
                            text: _searchController.text.isNotEmpty
                                ? 'No conversations match your search.'
                                : 'No messages yet',
                            size: 18,
                            weight: FontWeight.bold,
                            color: kblack,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          if (_searchController.text.isEmpty)
                            MyText(
                              text:
                                  "Looks like you haven't started a conversation yet.",
                              size: 13,
                              color: ktertiary,
                              textAlign: TextAlign.center,
                            ),
                          const SizedBox(height: 24),
                          if (_searchController.text.isEmpty)
                            GestureDetector(
                              onTap: _openNewMessage,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                decoration: BoxDecoration(
                                  color: kblue2,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                        Icons.chat_bubble_outline_rounded,
                                        color: Colors.white,
                                        size: 18),
                                    const SizedBox(width: 8),
                                    MyText(
                                      text: 'Start New Chat',
                                      size: 14,
                                      color: kwhite,
                                      weight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 8),
                  itemCount: chats.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: kgrey2, height: 1),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final unread =
                        provider.unreadChats?[chat.chatId] ?? 0;

                    return _ConversationTile(
                      chat: chat,
                      unread: unread,
                      timeLabel: _formatTime(chat.lastMessageTime),
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            page: Chats(
                              receiverId: chat.id,
                              title: chat.name,
                              avatarUrl: chat.avatarUrl,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 12,
                        width: 120,
                        color: Colors.white),
                    const SizedBox(height: 6),
                    Container(
                        height: 10,
                        width: 200,
                        color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final dynamic chat;
  final int unread;
  final String timeLabel;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.chat,
    required this.unread,
    required this.timeLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final initials = (chat.name as String)
        .split(' ')
        .map((n) => n.isNotEmpty ? n[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Avatar
            chat.avatarUrl != null
                ? CommonImageView(
                    url: chat.avatarUrl,
                    width: 50,
                    height: 50,
                    radius: 100,
                  )
                : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kmenuGreen.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: kblue2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(width: 12),
            // Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: chat.name,
                    size: 15,
                    weight: FontWeight.w600,
                    color: kblack,
                  ),
                  const SizedBox(height: 2),
                  MyText(
                    text: chat.lastMessage ?? '',
                    size: 12,
                    color: kdargrey,
                    weight: FontWeight.normal,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyText(
                  text: timeLabel,
                  size: 11,
                  color: kblack.withOpacity(0.5),
                ),
                const SizedBox(height: 4),
                if (unread > 0)
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '$unread',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
