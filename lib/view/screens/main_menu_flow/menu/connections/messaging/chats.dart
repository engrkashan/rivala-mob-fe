import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/chat_provider.dart';
import 'package:rivala/controllers/providers/user/auth_provider.dart';
import 'package:rivala/models/chat_model.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class Chats extends StatefulWidget {
  final String? title;
  final String receiverId;
  final String? avatarUrl;
  final bool? isGroup;

  const Chats({
    super.key,
    this.title,
    required this.receiverId,
    this.avatarUrl,
    this.isGroup = false,
  });

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _chatId = '';
  String _currentUserId = '';
  bool _showEmojiPicker = false;
  bool _showHeaderMenu = false;

  static const List<String> _emojis = ['❤️', '👍', '🔥', '😂', '😮', '😢', '🙏'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _currentUserId = context.read<AuthProvider>().currentUserId;
      final provider = context.read<ChatProvider>();
      await provider.getInitiateChat(widget.receiverId);

      final chat = provider.initiateChat;
      if (chat == null) return;

      _chatId = chat.id;
      await provider.loadMessages(_chatId);
      provider.markAsRead(_chatId);
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _chatId.isEmpty) return;
    _controller.clear();
    setState(() => _showEmojiPicker = false);
    await context.read<ChatProvider>().sendMessage(_chatId, text);
    _scrollToBottom();
  }

  void _startEdit(MessageModel msg) {
    context.read<ChatProvider>().setEditingMessage(msg.id);
    _controller.text = msg.content ?? '';
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    setState(() {});
  }

  void _cancelEdit() {
    context.read<ChatProvider>().setEditingMessage(null);
    _controller.clear();
    setState(() {});
  }

  void _showConfirmDialog({
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    bool isDanger = true,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.red.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: isDanger ? Colors.red : Colors.orange,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDanger ? Colors.red : Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(confirmText,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageMenu(MessageModel msg, bool isMe) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Emoji reactions row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _emojis
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            if (msg.id != null) {
                              context.read<ChatProvider>().reactToMessage(
                                  msg.id!, e, _chatId);
                            }
                          },
                          child: Text(e,
                              style: const TextStyle(fontSize: 28)),
                        ))
                    .toList(),
              ),
            ),
            const Divider(),
            // Edit (own messages only)
            if (isMe)
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit Message'),
                onTap: () {
                  Navigator.pop(context);
                  _startEdit(msg);
                },
              ),
            // Delete (own messages only)
            if (isMe)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Delete Message',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showConfirmDialog(
                    title: 'Delete Message?',
                    message:
                        'This will permanently remove this message for everyone.',
                    confirmText: 'Delete',
                    onConfirm: () {
                      if (msg.id != null) {
                        context
                            .read<ChatProvider>()
                            .deleteMessage(msg.id!);
                      }
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // ── Group messages by date — mirrors web's groupMessagesByDate ──────────────
  Map<String, List<MessageModel>> _groupByDate(List<MessageModel> msgs) {
    final Map<String, List<MessageModel>> groups = {};
    for (final msg in msgs) {
      final date = msg.createdAt != null
          ? _dateLabel(msg.createdAt!)
          : 'Today';
      groups.putIfAbsent(date, () => []).add(msg);
    }
    return groups;
  }

  String _dateLabel(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(dt.year, dt.month, dt.day);
    if (d == today) return 'Today';
    if (d == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return '${_month(dt.month)} ${dt.day}, ${dt.year}';
  }

  String _month(int m) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m - 1];
  }

  String _timeLabel(DateTime? dt) {
    if (dt == null) return '';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final initials = (widget.title ?? '?')
        .split(' ')
        .map((n) => n.isNotEmpty ? n[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    return GestureDetector(
      onTap: () => setState(() {
        _showEmojiPicker = false;
        _showHeaderMenu = false;
      }),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5FDF9),
        appBar: AppBar(
          backgroundColor: kwhite,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              // Avatar
              widget.avatarUrl != null
                  ? CommonImageView(
                      url: widget.avatarUrl,
                      width: 38,
                      height: 38,
                      radius: 100,
                    )
                  : Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: kmenuGreen.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(initials,
                            style: const TextStyle(
                                color: kblue2,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title ?? 'Chat',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                    // Typing indicator — mirrors web's "Typing..." subtitle
                    Consumer<ChatProvider>(
                      builder: (_, prov, __) => Text(
                        prov.isSending ? 'Sending...' : '',
                        style: const TextStyle(
                            fontSize: 11, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            // 3-dot menu — Clear Chat / Delete Chat — matches web header menu
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded,
                      color: Colors.black87),
                  onPressed: () =>
                      setState(() => _showHeaderMenu = !_showHeaderMenu),
                ),
                if (_showHeaderMenu)
                  Positioned(
                    right: 8,
                    top: 40,
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 190,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: kwhite,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: kgrey2),
                        ),
                        child: Column(
                          children: [
                            _menuItem(
                              icon: Icons.clear_all_rounded,
                              label: 'Clear Chat',
                              onTap: () {
                                setState(
                                    () => _showHeaderMenu = false);
                                _showConfirmDialog(
                                  title: 'Clear Conversation?',
                                  message:
                                      'This will delete all messages for both parties.',
                                  confirmText: 'Clear',
                                  isDanger: false,
                                  onConfirm: () {
                                    context
                                        .read<ChatProvider>()
                                        .clearChat(_chatId);
                                  },
                                );
                              },
                            ),
                            _menuItem(
                              icon: Icons.delete_outline_rounded,
                              label: 'Delete Chat',
                              color: Colors.red,
                              onTap: () {
                                setState(
                                    () => _showHeaderMenu = false);
                                _showConfirmDialog(
                                  title: 'Delete Conversation?',
                                  message:
                                      'This will permanently delete this conversation for everyone.',
                                  confirmText: 'Delete',
                                  onConfirm: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),

        body: Column(
          children: [
            // ── Messages list ─────────────────────────────────────────────
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading && provider.chats.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.chats.isEmpty) {
                    return Center(
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
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: const Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 48,
                                color: kblue2),
                          ),
                          const SizedBox(height: 16),
                          const Text('No messages yet',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                          const SizedBox(height: 6),
                          Text('Say hello and start connecting!',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[500])),
                        ],
                      ),
                    );
                  }

                  // Group by date — mirrors web groupMessagesByDate
                  final grouped = _groupByDate(provider.chats);
                  final dateKeys = grouped.keys.toList();

                  // Build flat list with date separators
                  final List<Widget> items = [];
                  for (final date in dateKeys) {
                    // Date separator
                    items.add(_DateSeparator(label: date));
                    for (final msg in grouped[date]!) {
                      // isSentBy: msg.sender?.id === userId (matches web)
                      final isMe = msg.sender?.id == _currentUserId ||
                          msg.senderId == _currentUserId;
                      items.add(_MessageBubble(
                        msg: msg,
                        isMe: isMe,
                        timeLabel: _timeLabel(msg.createdAt),
                        onLongPress: () => _showMessageMenu(msg, isMe),
                      ));
                    }
                  }

                  // Auto-scroll on new messages
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _scrollToBottom());

                  return ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    children: items,
                  );
                },
              ),
            ),

            // ── Edit mode indicator ───────────────────────────────────────
            Consumer<ChatProvider>(
              builder: (_, prov, __) {
                if (prov.editingMessageId == null) return const SizedBox();
                return Container(
                  color: kgrey4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.edit_outlined,
                          size: 16, color: kblue2),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('Editing message…',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700])),
                      ),
                      GestureDetector(
                        onTap: _cancelEdit,
                        child: const Icon(Icons.close,
                            size: 18, color: kdargrey),
                      ),
                    ],
                  ),
                );
              },
            ),

            // ── Emoji picker ─────────────────────────────────────────────
            if (_showEmojiPicker)
              Container(
                color: kwhite,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _emojis
                      .map((e) => GestureDetector(
                            onTap: () {
                              _controller.text += e;
                              _controller.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _controller.text.length),
                              );
                            },
                            child: Text(e,
                                style: const TextStyle(fontSize: 26)),
                          ))
                      .toList(),
                ),
              ),

            // ── Input bar ────────────────────────────────────────────────
            Container(
              color: kwhite,
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 10,
                bottom: Platform.isIOS ? 28 : 12,
              ),
              child: Row(
                children: [
                  // Emoji toggle
                  GestureDetector(
                    onTap: () => setState(
                        () => _showEmojiPicker = !_showEmojiPicker),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text('😊',
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  // Text input
                  Expanded(
                    child: Consumer<ChatProvider>(
                      builder: (_, prov, __) => TextField(
                        controller: _controller,
                        onSubmitted: (_) => _send(),
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          hintText: prov.editingMessageId != null
                              ? 'Edit message…'
                              : 'Type a message…',
                          hintStyle: TextStyle(
                              fontSize: 14, color: Colors.grey[400]),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  Consumer<ChatProvider>(
                    builder: (_, prov, __) => GestureDetector(
                      onTap: _send,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: prov.editingMessageId != null
                              ? kblue2
                              : kblack,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: kblack.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: prov.isSending
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white),
                              )
                            : const Icon(Icons.send_rounded,
                                color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: (color ?? kdargrey).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: color ?? kdargrey),
            ),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color ?? Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// ── Date separator widget ────────────────────────────────────────────────────
class _DateSeparator extends StatelessWidget {
  final String label;
  const _DateSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
              child: Divider(color: Colors.grey.withOpacity(0.3), height: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: Divider(color: Colors.grey.withOpacity(0.3), height: 1)),
        ],
      ),
    );
  }
}

// ── Message bubble ───────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final MessageModel msg;
  final bool isMe;
  final String timeLabel;
  final VoidCallback onLongPress;

  const _MessageBubble({
    required this.msg,
    required this.isMe,
    required this.timeLabel,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Sender name + avatar (others only)
          if (!isMe) ...[
            msg.sender?.avatarUrl != null
                ? CommonImageView(
                    url: msg.sender!.avatarUrl,
                    width: 28,
                    height: 28,
                    radius: 100,
                  )
                : Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: kmenuGreen.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (msg.sender?.name ?? '?').isNotEmpty
                            ? msg.sender!.name![0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                            fontSize: 11,
                            color: kblue2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            const SizedBox(width: 6),
          ],

          GestureDetector(
            onLongPress: onLongPress,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Sender name (others only)
                  if (!isMe && msg.sender?.name != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, left: 4),
                      child: Text(
                        msg.sender!.name!,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey[500]),
                      ),
                    ),

                  // Bubble
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      gradient: isMe ? kgradmainmenu : null,
                      color: isMe ? null : kwhite,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft:
                            Radius.circular(isMe ? 18 : 4),
                        bottomRight:
                            Radius.circular(isMe ? 4 : 18),
                      ),
                      border: isMe
                          ? null
                          : Border.all(
                              color: kgrey2.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg.content ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: isMe ? kwhite : Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),

                  // Timestamp
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 3, left: 4, right: 4),
                    child: Text(
                      timeLabel,
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
