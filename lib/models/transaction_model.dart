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
