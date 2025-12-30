import 'package:flutter/cupertino.dart';
import 'package:rivala/controllers/repos/promo_repo.dart';

import '../../models/promotions_model.dart';

class PromoProvider extends ChangeNotifier {
  List<PromotionModel> _promos = [];
  List<PromotionModel> get promos => _promos;

  List<dynamic> criteriaList = [];
  String promoCode = '';
  double discount = 0.0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> setPromos() async {
    setLoading(true);
    try {
      _promos = await PromoRepo().getPromos();
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  void addCriteria(Map<String, dynamic> criteria) {
    criteriaList.add(criteria);
    notifyListeners();
  }

  Future<void> uploadPromo(String title, String description, String startDate,
      String endDate, String status, String promo, double discount) async {
    setLoading(true);
    DateTime? start = _parseDate(startDate);
    DateTime? end = _parseDate(endDate);
    PromotionModel model = PromotionModel(
      title: title,
      description: description,
      startDate: start,
      endDate: end,
      status: status,
      promoCode: promo,
      discount: discount,
    );
    try {
      await PromoRepo().createPromo(model);
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  DateTime? _parseDate(String input) {
    input = input.trim(); // VERY important

    if (input.isEmpty) return null;

    // MM/DD/YYYY
    if (input.contains('/')) {
      final parts = input.split('/');
      if (parts.length == 3) {
        try {
          return DateTime(
            int.parse(parts[2].trim()), // YEAR
            int.parse(parts[0].trim()), // MONTH
            int.parse(parts[1].trim()), // DAY
          );
        } catch (_) {}
      }
    }

    return DateTime.tryParse(input); // fallback
  }
}
