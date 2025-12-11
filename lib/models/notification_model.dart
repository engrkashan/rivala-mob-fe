class NotificationModel {
  final String? id;
  final String? userId;
  final String? message;
  final bool? read;
  final DateTime? createdAt;
  final String? buyerId;

  const NotificationModel({
    this.id,
    this.userId,
    this.message,
    this.read,
    this.createdAt,
    this.buyerId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      message: json['message'] as String?,
      read: json['read'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      buyerId: json['buyerId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'read': read,
      'createdAt': createdAt?.toIso8601String(),
      'buyerId': buyerId,
    };
  }
}
