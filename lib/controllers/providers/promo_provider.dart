import 'package:flutter/cupertino.dart';
import 'package:rivala/controllers/repos/promo_repo.dart';

import '../../models/promotions_model.dart';

class PromoProvider extends ChangeNotifier {
  List<PromotionModel> _promos = [];
  List<PromotionModel> get promos => _promos;

  List<PromotionCriteriaModel> criteriaList = []; // Updated type
  List<PromotionTargetModel> targetList = []; // NEW
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

  void addCriteria(PromotionCriteriaModel criteria) {
    criteriaList.add(criteria);
    notifyListeners();
  }

  void addTarget(PromotionTargetModel target) {
    targetList.add(target);
    notifyListeners();
  }

  void setDataFromPromo(PromotionModel? promo) {
    if (promo == null) return;
    criteriaList = List<PromotionCriteriaModel>.from(promo.criteria ?? []);
    targetList = List<PromotionTargetModel>.from(promo.targets ?? []);
    notifyListeners();
  }

  Future<void> uploadPromo({
    String? id, // Added id for update
    required String title,
    required String description,
    required String startDate,
    required String endDate,
    required String status,
    required String promo,
    required double discount,
    required String targetAudience,
  }) async {
    setLoading(true);
    DateTime? start = _parseDate(startDate);
    DateTime? end = _parseDate(endDate);
    PromotionModel model = PromotionModel(
      title: title,
      description: description,
      startDate: start,
      endDate: end,
      status: status,
      promoCode: promo.isEmpty ? null : promo,
      discount: discount,
      targetAudience: targetAudience,
      targets: targetList,
      criteria: criteriaList,
    );
    try {
      if (id != null) {
        // Map targets and criteria for update as well
        final List<Map<String, dynamic>> criteriaJson = criteriaList
            .map((c) => {"condition": c.condition, "action": c.action})
            .toList();
        final List<Map<String, dynamic>> targetJson = targetList.map((t) {
          return {
            "type": t.targetType,
            "id": t.targetType == "PRODUCT" ? t.productId : t.collectionId,
          };
        }).toList();

        await PromoRepo().updatePromo(id, {
          "title": title,
          "description": description,
          "startDate": start?.toIso8601String(),
          "endDate": end?.toIso8601String(),
          "status": status == "Live" ? "ACTIVE" : "INACTIVE",
          "promoCode": promo.isEmpty ? null : promo,
          "discount": discount,
          "targets": targetJson,
          "criteria": criteriaJson,
        });
      } else {
        await PromoRepo().createPromo(model);
      }
    } catch (e) {
      print("Error creating/updating promo: $e");
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

  Future<void> addProductToPromo(String promoId, String productId) async {
    final index = _promos.indexWhere((p) => p.id == promoId);
    if (index == -1) return;

    final promo = _promos[index];

    // Convert existing targets to simplified backend format: { type, id }
    final List<Map<String, dynamic>> consolidatedTargets =
        (promo.targets ?? []).map((t) {
      return {
        "type": t.targetType?.toUpperCase(),
        "id": t.targetType?.toUpperCase() == "PRODUCT"
            ? t.productId
            : t.collectionId,
      };
    }).toList();

    // Check if already exists
    bool alreadyExists = consolidatedTargets
        .any((t) => t['type'] == 'PRODUCT' && t['id'] == productId);

    if (alreadyExists) return;

    consolidatedTargets.add({
      "type": "PRODUCT",
      "id": productId,
    });

    setLoading(true);
    try {
      await PromoRepo().updatePromo(promoId, {
        "targets": consolidatedTargets,
      });
      await setPromos(); // Refresh local list
    } catch (e) {
      print("Error adding product to promo: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> togglePromoStatus(String id, String currentStatus) async {
    setLoading(true);
    final newStatus = currentStatus == "ACTIVE" ? "PAUSED" : "ACTIVE";
    try {
      await PromoRepo().updatePromo(id, {"status": newStatus});
      await setPromos(); // Refresh list
    } catch (e) {
      print("Error toggling promo status: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> deletePromo(String id) async {
    setLoading(true);
    try {
      await PromoRepo().deletePromo(id);
      await setPromos(); // Refresh list
    } catch (e) {
      print("Error deleting promo: $e");
    } finally {
      setLoading(false);
    }
  }

  void clearData() {
    criteriaList.clear();
    targetList.clear();
    promoCode = '';
    discount = 0.0;
    notifyListeners();
  }
}
