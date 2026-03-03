import 'package:flutter/cupertino.dart';

import '../../models/theme_model.dart';
import '../repos/theme_repo.dart';

class ThemeProvider extends ChangeNotifier {
  List<ThemeModel> _themes = [];
  List<ThemeModel> get themes => _themes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String _error = "";
  String get error => _error;

  final ThemeRepo _themeRepo = ThemeRepo();

  Future<void> loadAllThemes() async {
    setLoading(true);
    try {
      _themes = await _themeRepo.getAllThemes();
      _error = "";
    } catch (e) {
      _error = e.toString();
      _themes = [];
    } finally {
      setLoading(false);
    }
  }

  Future<ThemeModel?> addCustomTheme(ThemeModel theme) async {
    setLoading(true);
    try {
      final createdTheme = await _themeRepo.createCustomTheme(theme);
      _error = "";
      await loadAllThemes(); // Refresh the themes list after adding a new one
      return createdTheme;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      setLoading(false);
    }
  }

  String? _attachedThemeId;
  String? get attachedThemeId => _attachedThemeId;

  Future<void> loadAttachedTheme() async {
    // Don't set global loading here to avoid flickering entire UI if just refreshing status
    try {
      _attachedThemeId = await _themeRepo.getAttachedThemeId();
      notifyListeners();
    } catch (e) {
      print("Error loading attached theme: $e");
    }
  }

  Future<void> attach(String themeId) async {
    setLoading(true);
    try {
      await _themeRepo.attachTheme(themeId);
      _attachedThemeId = themeId;
      _error = "";
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> detach() async {
    setLoading(true);
    try {
      await _themeRepo.detachTheme();
      _attachedThemeId = null;
      _error = "";
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
