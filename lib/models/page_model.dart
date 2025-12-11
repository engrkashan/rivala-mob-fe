class PageModel {
  final String? id;
  final String? storeId;
  final String? title;
  final String? slug;
  final bool? isVisible;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PageSectionModel>? sections;

  const PageModel({
    this.id,
    this.storeId,
    this.title,
    this.slug,
    this.isVisible,
    this.createdAt,
    this.updatedAt,
    this.sections,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'] as String?,
      storeId: json['storeId'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      isVisible: json['isVisible'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => PageSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'title': title,
      'slug': slug,
      'isVisible': isVisible,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'sections': sections?.map((e) => e.toJson()).toList(),
    };
  }
}

class PageSectionModel {
  final String? id;
  final String? pageId;
  final String? title;
  final String? type;
  final int? order;
  final Map<String, dynamic>? settings;
  final List<SectionBlockModel>? blocks;

  const PageSectionModel({
    this.id,
    this.pageId,
    this.title,
    this.type,
    this.order,
    this.settings,
    this.blocks,
  });

  factory PageSectionModel.fromJson(Map<String, dynamic> json) {
    return PageSectionModel(
      id: json['id'] as String?,
      pageId: json['pageId'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      order: json['order'] as int?,
      settings: json['settings'] as Map<String, dynamic>?,
      blocks: (json['blocks'] as List<dynamic>?)
          ?.map((e) => SectionBlockModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pageId': pageId,
      'title': title,
      'type': type,
      'order': order,
      'settings': settings,
      'blocks': blocks?.map((e) => e.toJson()).toList(),
    };
  }
}

class SectionBlockModel {
  final String? id;
  final String? sectionId;
  final String? type; // BlockType enum in schema
  final Map<String, dynamic>? content;
  final int? order;

  const SectionBlockModel({
    this.id,
    this.sectionId,
    this.type,
    this.content,
    this.order,
  });

  factory SectionBlockModel.fromJson(Map<String, dynamic> json) {
    return SectionBlockModel(
      id: json['id'] as String?,
      sectionId: json['sectionId'] as String?,
      type: json['type'] as String?,
      content: json['content'] as Map<String, dynamic>?,
      order: json['order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sectionId': sectionId,
      'type': type,
      'content': content,
      'order': order,
    };
  }
}
