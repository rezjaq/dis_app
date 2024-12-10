import 'package:dis_app/models/photo_model.dart';

class Detail {
  final String sellerId;
  final List<String> photoIds;
  final double total;

  Detail({
    required this.sellerId,
    required this.photoIds,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'seller_id': sellerId,
      'photo_id': photoIds,
      'total': total,
    };
  }
}

class Payment {
  final String id;
  final String status;
  final String type = 'qris';
  final String url;
  final DateTime expiredAt;

  Payment({
    required this.id,
    required this.status,
    required this.url,
    required this.expiredAt,
  });
}

class Transaction {
  final String id;
  final String buyerId;
  final List<Detail> details;
  final DateTime date = DateTime.now();
  final double total;
  final String status;
  final Payment? payment;

  Transaction({
    required this.id,
    required this.buyerId,
    required this.details,
    required this.total,
    required this.status,
    this.payment,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      buyerId: json['buyer_id'] ?? '',
      details: (json['details'] as List)
          .map((e) => Detail(
                sellerId: e['seller_id'],
                photoIds: (e['photo_ids'] as List).map((e) => e.toString()).toList(),
                total: e['total'],
              ))
          .toList(),
      total: json['total'],
      status: json['status'],
      payment: json['payment'] != null
          ? Payment(
              id: json['payment']['id'],
              status: json['payment']['status'],
              url: json['payment']['url'],
              expiredAt: DateTime.parse(json['payment']['expired_at']),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyer_id': buyerId,
      'details': details.map((e) => {
        'seller_id': e.sellerId,
        'photo_id': e.photoIds,
        'total': e.total,
      }).toList(),
      'total': total,
      'status': status,
      'payment': payment != null
          ? {
              'id': payment!.id,
              'status': payment!.status,
              'type': payment!.type,
              'url': payment!.url,
              'expired_at': payment!.expiredAt.toIso8601String(),
            }
          : null,
    };
  }
}

class DetailHistory {
  final String username;
  final List<PhotoHistory> photos;
  final double total;

  DetailHistory({
    required this.username,
    required this.photos,
    required this.total,
  });

  factory DetailHistory.fromJson(Map<String, dynamic> json) {
    return DetailHistory(
      username: json['username'] ?? '',
      photos: (json['photos'] as List)
          .map((e) => PhotoHistory.fromJson(e))
          .toList(),
      total: json['total'],
    );
  }
}

class TransactionHistory {
  final String id;
  final String status;
  final DateTime date;
  final List<DetailHistory> details;
  final double total;

  TransactionHistory({
    required this.id,
    required this.status,
    required this.date,
    required this.details,
    required this.total,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      date: DateTime.parse(json['date']),
      details: (json['details'] as List)
          .map((e) => DetailHistory.fromJson(e))
          .toList(),
      total: json['total'],
    );
  }
}

class TransactionHistorySeller {
  final String photoName;
  final String photoUrl;
  final DateTime date;
  final String username;
  final double price;

  TransactionHistorySeller({
    required this.photoName,
    required this.photoUrl,
    required this.date,
    required this.username,
    required this.price,
  });

  factory TransactionHistorySeller.fromJson(Map<String, dynamic> json) {
    return TransactionHistorySeller(
      photoName: json['photo_name'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      date: DateTime.parse(json['date']),
      username: json['username'] ?? '',
      price: json['price'],
    );
  }
}

class CreateTransactionRequest {
  final List<Detail> details;
  final double total;

  CreateTransactionRequest({
    required this.details,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'details': details.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}

class GetTransactionRequest {
  final String id;
  GetTransactionRequest({required this.id});
}

class ListTransactionRequest {
  int? page;
  int? size;

  ListTransactionRequest({
    this.page,
    this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }

  String toQueryParams() {
    final params = toJson();
    params.removeWhere((key, value) => value == null);
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}

class UpdateTransactionRequest {
  final String id;
  final double amount;
  final String description;

  UpdateTransactionRequest({
    required this.id,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
    };
  }
}

class DeleteTransactionRequest {
  final String id;

  DeleteTransactionRequest({required this.id});
}
