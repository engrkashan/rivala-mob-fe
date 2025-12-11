class FollowModel {
  String? id;
  String? name;
  String? username;
  String? avatarUrl;
  String? followerId;
  String? createdAt;

  FollowModel({
    this.id,
    this.name,
    this.username,
    this.avatarUrl,
    this.followerId,
    this.createdAt,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    final follower = json["follower"] ?? {};

    return FollowModel(
      id: json["id"],
      followerId: follower["id"],
      name: follower["name"],
      username: follower["username"],
      avatarUrl: follower["avatarUrl"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "followerId": followerId,
        "name": name,
        "username": username,
        "avatarUrl": avatarUrl,
        "createdAt": createdAt,
      };
}
