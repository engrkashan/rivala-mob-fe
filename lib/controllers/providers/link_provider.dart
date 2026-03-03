import 'package:flutter/cupertino.dart';
import 'package:rivala/controllers/repos/link_repo.dart';

import '../../models/link_model.dart';

class LinkProvider extends ChangeNotifier {
  List<LinkModel> _links = [];
  List<LinkModel> get links => _links;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> loadLinks(BuildContext context) async {
    setLoading(true);
    try {
      _links = await LinkRepo().getLinks(context);
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  Future<void> setLink(
      String name, String url, String thumbnailUrl, String storeId) async {
    setLoading(true);
    try {
      await LinkRepo().createLink(LinkModel(
          name: name, url: url, thumbnailUrl: thumbnailUrl, storeId: storeId));
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> setLinks(List<LinkModel> links) async {
    setLoading(true);
    try {
      for (var link in links) {
        await LinkRepo().createLink(link);
      }
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void toggleLinkStatus(int index) {
    if (index >= 0 && index < _links.length) {
      final currentStatus = _links[index].status;
      final newStatus = currentStatus == 'active' ? 'inactive' : 'active';
      _links[index] = _links[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }
}
