class Withdraw {
  final String id;
  final String userId;
  final String bankId;
  final String? bank;
  final double amount;
  final String status;
  final String? receipt;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Withdraw({
    required this.id,
    required this.userId,
    required this.bankId,
    this.bank,
    required this.amount,
    required this.status,
    this.receipt,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Withdraw.fromJson(Map<String, dynamic> json) {
    return Withdraw(
      id: json['_id'],
      userId: json['user_id'],
      bankId: json['account_id'],
      bank: json['bank'],
      amount: json['amount'],
      status: json['status'],
      receipt: json['receipt'],
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
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