import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/chat_repo.dart';
import 'package:rivala/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  List<MessageModel> _chats = [];
  List<MessageModel> get chats => _chats;

  Map<String, int>? _unreadChats;
  Map<String, int>? get unreadChats => _unreadChats;

  List<ChatUser> _allChats = [];
  List<ChatUser> get allChats => _allChats;

  ChatModel? _initiateChat;
  ChatModel? get initiateChat => _initiateChat;

  // List<ChatModel> _filteredChats = [];
  // List<ChatModel> get filteredChats => _filteredChats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSending = false;
  bool get isSending => _isSending;

  String? _error;
  String? get error => _error;

  final ChatRepo _repo = ChatRepo();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setSending(bool value) {
    _isSending = value;
    notifyListeners();
  }

  Future<void> loadMessages(String chatId) async {
    setLoading(true);
    try {
      final messages = await _repo.getMessages(chatId);
      _chats = messages;
      // _filteredChats = _chats;
      _error = "";
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    if (content.isEmpty) return;
    setSending(true);
    try {
      final newMessage = await _repo.sendMessage(chatId, content);
      _chats.add(newMessage);
      getAllChats();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      // Optionally show a snackbar or toast here via a service or callback
    } finally {
      setSending(false);
    }
  }

  Future<void> loadUnreadMessages() async {
    try {
      final messages = await _repo.getUnreadMessages();
      _unreadChats = messages;
      notifyListeners();
    } catch (e) {
      print("Error loading unread messages: $e");
    }
  }

  Future<void> getInitiateChat(String receiverId) async {
    setLoading(true);
    try {
      _initiateChat = await _repo.initiateChat(receiverId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllChats() async {
    setLoading(true);
    try {
      _allChats = await _repo.getChats();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _allChats = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> markAsRead(String chatId) async {
    try {
      await _repo.markAsRead(chatId);
      loadUnreadMessages();
    } catch (e) {
      _error = e.toString();
    }
  }
}
