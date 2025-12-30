class FollowModel {
  String? id;
  String? name;
  String? username;
  String? logo;
  String? followerId;
  String? createdAt;
  String? ownerId;

  FollowModel({
    this.id,
    this.name,
    this.username,
    this.logo,
    this.followerId,
    this.createdAt,
    this.ownerId,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    // If follower object exists → followers API
    final bool hasFollower = json.containsKey("follower") && json["follower"] != null;

    final Map<String, dynamic> data =
    hasFollower ? json["follower"] : json;

    return FollowModel(
      id: json["id"] ?? data["id"],
      followerId: data["id"],
      name: data["name"],
      username: data["username"] ?? data["slug"],
      logo: data["logo"] ?? data["avatarUrl"],
      ownerId: json["ownerId"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "followerId": followerId,
    "name": name,
    "username": username,
    "logo": logo,
    "ownerId": ownerId,
    "createdAt": createdAt,
  };
}
