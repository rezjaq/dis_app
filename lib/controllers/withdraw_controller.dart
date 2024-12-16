import 'package:dis_app/models/withdraw_model.dart';
import 'package:dis_app/utils/http/http_client.dart';

class WithdrawController {
  Future<Withdraw> create(WithdrawCreateRequest request) async {
    try {
      final response = await DisHttpClient.post('withdrawal/', request.toJson());
      if (response['data'] == null) {
        print("Error: ${response}");
        throw response['errors'];
      } else {
        print("Success: ${response['data']}");
        return Withdraw.fromJson(response['data']);
      }
    } catch (e) {
      throw Exception('Failed to create withdrawal: $e');
    }
  }

  Future<List<Withdraw>> list(ListWithdrawRequest request) async {
    try {
      final queryParams = request.toQueryParams();
      final response = await DisHttpClient.get('withdrawal/?$queryParams');
      if (response['data'] == null) {
        throw Exception(response['errors']);
      }
      return List<Withdraw>.from(response['data'].map((x) => Withdraw.fromJson(x)));
    } catch (e) {
      throw Exception('Failed to list withdrawals: $e');
    }
  }
}