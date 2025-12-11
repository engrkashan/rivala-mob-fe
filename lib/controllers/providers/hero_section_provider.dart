import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/hero_section_repo.dart';
import 'package:rivala/models/hero_section_model.dart';

class HeroSectionProvider extends ChangeNotifier {
  final _heroSectionRepo = HeroSectionRepo();

  bool _isLoading = false;
  String? _error;
  HeroSectionModel? _heroSection;

  bool get isLoading => _isLoading;
  String? get error => _error;
  HeroSectionModel? get heroSection => _heroSection;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadHeroSection() async {
    setLoading(true);
    try {
      _heroSection = await _heroSectionRepo.getHeroSection();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _heroSection = null;
    } finally {
      setLoading(false);
    }
  }
}
