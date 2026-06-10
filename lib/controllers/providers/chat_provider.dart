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

  // Filtered list for search in conversation list
  List<ChatUser> _filteredChats = [];
  List<ChatUser> get filteredChats => _filteredChats;

  ChatModel? _initiateChat;
  ChatModel? get initiateChat => _initiateChat;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSending = false;
  bool get isSending => _isSending;

  // Editing state
  String? _editingMessageId;
  String? get editingMessageId => _editingMessageId;
  void setEditingMessage(String? id) {
    _editingMessageId = id;
    notifyListeners();
  }

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

  void clearChatState() {
    _chats = [];
    _initiateChat = null;
    notifyListeners();
  }

  // ─── Messages ──────────────────────────────────────────────────────────────

  Future<void> loadMessages(String chatId) async {
    setLoading(true);
    try {
      final messages = await _repo.getMessages(chatId);
      _chats = messages;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    if (content.trim().isEmpty) return;
    setSending(true);
    try {
      if (_editingMessageId != null) {
        // Edit existing message
        final updated = await _repo.editMessage(_editingMessageId!, content);
        final idx = _chats.indexWhere((m) => m.id == _editingMessageId);
        if (idx != -1) _chats[idx] = updated;
        _editingMessageId = null;
      } else {
        // New message
        final newMessage = await _repo.sendMessage(chatId, content);
        _chats.add(newMessage);
      }
      getAllChats();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    } finally {
      setSending(false);
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await _repo.deleteMessage(messageId);
      _chats.removeWhere((m) => m.id == messageId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  Future<void> reactToMessage(
      String messageId, String type, String chatId) async {
    try {
      await _repo.reactToMessage(messageId, type, chatId);
      // Reload messages to get fresh reactions
      await loadMessages(chatId);
    } catch (e) {
      _error = e.toString();
    }
  }

  Future<void> clearChat(String chatId) async {
    try {
      await _repo.clearChat(chatId);
      _chats.clear();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  // ─── Conversation List ─────────────────────────────────────────────────────

  Future<void> loadUnreadMessages() async {
    try {
      final messages = await _repo.getUnreadMessages();
      _unreadChats = messages;
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading unread messages: $e");
    }
  }

  Future<void> getAllChats() async {
    setLoading(true);
    try {
      _allChats = await _repo.getChats();
      // Sort by lastMessageTime descending — matches web sidebar sort
      _allChats.sort((a, b) {
        final aTime = a.lastMessageTime ?? DateTime(2000);
        final bTime = b.lastMessageTime ?? DateTime(2000);
        return bTime.compareTo(aTime);
      });
      _filteredChats = List.from(_allChats);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _allChats = [];
      _filteredChats = [];
    } finally {
      setLoading(false);
    }
  }

  void searchChats(String query) {
    if (query.trim().isEmpty) {
      _filteredChats = List.from(_allChats);
    } else {
      final q = query.toLowerCase();
      _filteredChats = _allChats.where((c) {
        return c.name.toLowerCase().contains(q) ||
            (c.lastMessage ?? '').toLowerCase().contains(q);
      }).toList();
    }
    notifyListeners();
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

  Future<void> markAsRead(String chatId) async {
    try {
      await _repo.markAsRead(chatId);
      loadUnreadMessages();
    } catch (e) {
      _error = e.toString();
    }
  }
}
