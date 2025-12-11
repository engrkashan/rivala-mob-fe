class FulfillmentModel {
  String? id;
  String? type;
  String? name;
  String? apiKey;
  String? apiSecret;
  String? contactEmail;
  DateTime? createdAt;
  DateTime? updatedAt;

  FulfillmentModel({
    this.id,
    this.type,
    this.name,
    this.apiKey,
    this.apiSecret,
    this.contactEmail,
    this.createdAt,
    this.updatedAt,
  });

  factory FulfillmentModel.fromJson(Map<String, dynamic> json) =>
      FulfillmentModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        apiKey: json["apiKey"],
        apiSecret: json["apiSecret"],
        contactEmail: json["contactEmail"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "apiKey": apiKey,
        "apiSecret": apiSecret,
        "contactEmail": contactEmail,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
