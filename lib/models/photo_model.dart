class PostPhoto {
  final String id;
  final String url;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  PostPhoto({
    required this.id,
    required this.url,
    required this.name,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PostPhoto.fromJson(Map<String, dynamic> json) {
    return PostPhoto(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}

class SellPhoto {
  final String id;
  final String url;
  final String name;
  final double basePrice;
  final double sellPrice;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  SellPhoto({
    required this.id,
    required this.url,
    required this.name,
    required this.basePrice,
    required this.sellPrice,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'basePrice': basePrice,
      'sellPrice': sellPrice,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}