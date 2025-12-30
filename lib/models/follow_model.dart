class FollowModel {
  String? id;
  String? name;
  String? username;
  String? logo;
  String? followerId;
  String? createdAt;
  String? ownerId;

  FollowModel(
      {this.id,
      this.name,
      this.username,
      this.logo,
      this.followerId,
      this.createdAt,
      this.ownerId});

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    final follower = json["follower"] ?? {};

    return FollowModel(
      id: json["id"],
      followerId: follower["id"],
      name: follower["name"],
      username: follower["username"],
      logo: follower["logo"] ?? follower["avatarUrl"],
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
