class CategoryModel {
  final String? id;
  final String? name;
  final String? description;
  final String? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CategoryModel>? children;

  const CategoryModel({
    this.id,
    this.name,
    this.description,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'parentId': parentId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'children': children?.map((e) => e.toJson()).toList(),
    };
  }
}
