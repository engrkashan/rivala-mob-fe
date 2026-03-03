import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/models/chat_model.dart';

import '../../config/network/endpoints.dart';

class ChatRepo {
  ApiClient api = ApiClient();

  Future<List<MessageModel>> getMessages(String chatId) async {
    final res = await api.getResponse(
      endpoints: Endpoints.messagesHistory,
      query: {"chatId": chatId},
    );
    final list = res['users'] as List;
    return list.map((item) => MessageModel.fromJson(item)).toList();
  }

  Future<ChatModel> initiateChat(String receiverId) async {
    final res = await api.postResponse(
        endpoints: Endpoints.initiateChat, data: {"receiverId": receiverId});

    return ChatModel.fromJson(res['chat']);
  }

  Future<MessageModel> sendMessage(String chatId, String content) async {
    final res = await api.postResponse(
      endpoints: Endpoints.messages,
      data: {
        "chatId": chatId,
        "content": content,
      },
    );
    return MessageModel.fromJson(res['message']);
  }

  Future<Map<String, int>> getUnreadMessages() async {
    final res = await api.getResponse(endpoints: Endpoints.messagesUnread);
    return Map<String, int>.from(res['unreadCounts'] ?? {});
  }

  Future<List<ChatUser>> getChats() async {
    final res = await api.getResponse(endpoints: Endpoints.chatUsers);
    final list = res['users'] as List;
    return list.map((item) => ChatUser.fromJson(item)).toList();
  }

  Future<void> markAsRead(String chatId) async {
    await api.postResponse(endpoints: Endpoints.markAsRead(chatId));
  }
}
