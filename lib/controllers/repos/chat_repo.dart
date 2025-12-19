import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/models/chat_model.dart';

import '../../config/network/endpoints.dart';

class ChatRepo {
  ApiClient api = ApiClient();

  Future<List<ChatModel>> getMessages(String receiverId) async {
    final res = await api.getResponse(
      endpoints: Endpoints.messagesHistory,
      query: {
        "receiverId": receiverId,
      },
    );
    final list = res['messages'] as List;
    return list.map((item) => ChatModel.fromJson(item)).toList();
  }

  Future<ChatModel> sendMessage(
      String receiverId, String content, String senderId) async {
    final res = await api.postResponse(
      endpoints: Endpoints.messages,
      data: {
        "receiverId": receiverId,
        "senderId": senderId,
        "content": content,
      },
    );
    return ChatModel.fromJson(res['message']);
  }

  Future<List<ChatModel>> getUnreadMessages() async {
    final res = await api.getResponse(endpoints: Endpoints.messagesUnread);
    final list = res['unreadMessages'] as List;
    return list.map((item) => ChatModel.fromJson(item)).toList();
  }
}
