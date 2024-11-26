import 'dart:convert';
import 'package:dis_app/models/transaction_model.dart';
import 'package:dis_app/utils/http/http_client.dart';

class TransactionController {
  // Create Transaction
  Future<Map<String, dynamic>> createTransaction(CreateTransactionRequest request) async {
    try {
      final response = await DisHttpClient.post('transaction', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to create transaction: $e');
    }
  }

  // Get Transaction by ID
  Future<Map<String, dynamic>> getTransaction(GetTransactionRequest request) async {
    try {
      final response = await DisHttpClient.get('transaction/${request.id}');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to get transaction: $e');
    }
  }

  // List Transactions
  Future<Map<String, dynamic>> listTransactions(ListTransactionRequest request) async {
    try {
      final queryParams = request.toQueryParams();
      final response = await DisHttpClient.get('transaction?$queryParams');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('Failed to list transactions: $e');
    }
  }

  // Update Transaction
  Future<Map<String, dynamic>> updateTransaction(UpdateTransactionRequest request) async {
    try {
      final response = await DisHttpClient.patch('transaction/${request.id}', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to update transaction: $e');
    }
  }

  // Delete Transaction
  Future<Map<String, dynamic>> deleteTransaction(DeleteTransactionRequest request) async {
    try {
      final response = await DisHttpClient.delete('transaction/${request.id}');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }
}
