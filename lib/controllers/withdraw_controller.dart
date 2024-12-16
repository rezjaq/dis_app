import 'package:dis_app/models/withdraw_model.dart';
import 'package:dis_app/utils/http/http_client.dart';

class WithdrawController {
  Future<Withdraw> create(WithdrawCreateRequest request) async {
    try {
      final response = await DisHttpClient.post('withdrawal', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return Withdraw.fromJson(response['data']);
      }
    } catch (e) {
      throw Exception('Failed to create withdrawal: $e');
    }
  }
}