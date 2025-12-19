import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/chat_repo.dart';
import 'package:rivala/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chats = [];
  List<ChatModel> get chats => _chats;

  // List<ChatModel> _filteredChats = [];
  // List<ChatModel> get filteredChats => _filteredChats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSending = false;
  bool get isSending => _isSending;

  String _error = "";
  String get error => _error;

  final ChatRepo _repo = ChatRepo();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setSending(bool value) {
    _isSending = value;
    notifyListeners();
  }

  Future<void> loadMessages(String receiverId) async {
    setLoading(true);
    try {
      final messages = await _repo.getMessages(receiverId);
      _chats = messages;
      // _filteredChats = _chats;
      _error = "";
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendMessage(
      String content, String receiverId, String senderId) async {
    if (content.isEmpty) return;
    setSending(true);
    try {
      final newMessage = await _repo.sendMessage(receiverId, content, senderId);
      _chats.add(newMessage);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      // Optionally show a snackbar or toast here via a service or callback
    } finally {
      setSending(false);
    }
  }

  // Unread messages logic
  List<ChatModel> _unreadMessages = [];
  List<ChatModel> get unreadMessages => _unreadMessages;

  Future<void> loadUnreadMessages() async {
    try {
      final messages = await _repo.getUnreadMessages();
      _unreadMessages = messages;
      notifyListeners();
    } catch (e) {
      print("Error loading unread messages: $e");
    }
  }
}
