class ReportModel {
  final String? id;
  final String? reporterId;
  final String? targetId;
  final String? reason;
  final DateTime? createdAt;

  const ReportModel({
    this.id,
    this.reporterId,
    this.targetId,
    this.reason,
    this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String?,
      reporterId: json['reporterId'] as String?,
      targetId: json['targetId'] as String?,
      reason: json['reason'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporterId': reporterId,
      'targetId': targetId,
      'reason': reason,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
