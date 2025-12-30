import 'dart:convert';

RestrictionsResponse restrictionsResponseFromJson(String str) =>
    RestrictionsResponse.fromJson(json.decode(str));

class RestrictionsResponse {
  final List<SellerRestriction> restrictions;

  RestrictionsResponse({
    required this.restrictions,
  });

  factory RestrictionsResponse.fromJson(Map<String, dynamic> json) {
    return RestrictionsResponse(
      restrictions: json['restrictions'] == null
          ? []
          : List<SellerRestriction>.from(
              json['restrictions'].map(
                (x) => SellerRestriction.fromJson(x),
              ),
            ),
    );
  }
}

class SellerRestriction {
  final String id;
  final String type;
  final String? targetId;
  final String reason;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  SellerRestriction({
    required this.id,
    required this.type,
    this.targetId,
    required this.reason,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SellerRestriction.fromJson(Map<String, dynamic> json) {
    return SellerRestriction(
      id: json['id'],
      type: json['type'],
      targetId: json['targetId'],
      reason: json['reason'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
