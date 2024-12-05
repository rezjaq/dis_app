class Detail {
  final String sellerId;
  final List<String> photoIds;
  final double total;

  Detail({
    required this.sellerId,
    required this.photoIds,
    required this.total,
  });
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

class CreateTransactionRequest {
  final String userId;
  final double amount;
  final String description;

  CreateTransactionRequest({
    required this.userId,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'amount': amount,
      'description': description,
    };
  }
}

class GetTransactionRequest {
  final String id;

  GetTransactionRequest({required this.id});
}

class ListTransactionRequest {
  final int page;
  final int limit;

  ListTransactionRequest({required this.page, required this.limit});

  String toQueryParams() {
    return 'page=$page&limit=$limit';
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
