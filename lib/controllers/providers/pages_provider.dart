import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/pages_repo.dart';
import 'package:rivala/models/page_model.dart';

class PagesProvider extends ChangeNotifier {
  final _pagesRepo = PagesRepo();

  bool _isLoading = false;
  String? _error;
  PageModel? _currentPage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  PageModel? get currentPage => _currentPage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadPageBySlug(String slug) async {
    setLoading(true);
    try {
      _currentPage = await _pagesRepo.getPageBySlug(slug);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentPage = null;
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadPageById(String id) async {
    setLoading(true);
    try {
      _currentPage = await _pagesRepo.getPageById(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _currentPage = null;
    } finally {
      setLoading(false);
    }
  }

  List<PageModel> _pages = [];
  List<PageModel> get pages => _pages;

  Future<void> loadAllPages() async {
    setLoading(true);
    try {
      _pages = await _pagesRepo.listPages();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _pages = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> createPage({
    required String title,
    required String slug,
    bool isVisible = true,
  }) async {
    setLoading(true);
    try {
      final newPage = await _pagesRepo.createPage(
        title: title,
        slug: slug,
        isVisible: isVisible,
      );
      _pages.add(newPage);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> updatePage({
    required String id,
    String? title,
    int? order,
    bool? isVisible,
    List<Map<String, dynamic>>? sections,
  }) async {
    setLoading(true);
    try {
      final updatedPage = await _pagesRepo.updatePage(
        id: id,
        title: title,
        order: order,
        isVisible: isVisible,
        sections: sections,
      );
      final index = _pages.indexWhere((p) => p.id == id);
      if (index != -1) {
        _pages[index] = updatedPage;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> deletePage(String id) async {
    setLoading(true);
    try {
      await _pagesRepo.deletePage(id);
      _pages.removeWhere((p) => p.id == id);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
