class Withdraw {
  final String id;
  final String userId;
  final String bankId;
  final String bank;
  final String amount;
  final String status;
  final String receipt;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Withdraw({
    required this.id,
    required this.userId,
    required this.bankId,
    required this.bank,
    required this.amount,
    required this.status,
    required this.receipt,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) {
    return Withdraw(
      id: json['id'],
      userId: json['user_id'],
      bankId: json['account_id'],
      bank: json['bank'] ?? '',
      amount: json['amount'],
      status: json['status'],
      receipt: json['receipt'] ?? '',
      note: json['note'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
    );
  }
}

class WithdrawCreateRequest {
  final String bankId;
  final double amount;

  WithdrawCreateRequest({
    required this.bankId,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'account_id': bankId,
      'amount': amount,
    };
  }
}

class ListWithdrawRequest {
  int? page;
  int? size;

  ListWithdrawRequest({
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