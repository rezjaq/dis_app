class MatchedPhoto {
  final String id;
  final String url;
  final String userId;
  final String? buyerId;

  MatchedPhoto({
    required this.id,
    required this.url,
    required this.userId,
    this.buyerId,
  });

  factory MatchedPhoto.fromJson(Map<String, dynamic> json) {
    return MatchedPhoto(
      id: json['_id'] ?? '',
      url: json['url'] ?? '',
      userId: json['user_id'] ?? '',
      buyerId: json['buyer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'url': url,
      'user_id': userId,
      'buyer_id': buyerId,
    };
  }
}
