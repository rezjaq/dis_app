import 'package:dis_app/models/user_model.dart';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:dis_app/utils/local_storage/local_storage.dart';

class AuthController {
  Future<Map<String, dynamic>> register(RegisterUserRequest request) async{
    try {
      final response = await DisHttpClient.post('user/register', request.toJson());
      print("Response: $response");
      if (response['data'] == null) {
        throw response['errors'];
      }
      else {
        return response['data'];
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to register user: $e');
    }
  }

  Future<Map<String, dynamic>> login(LoginUserRequest request) async{
    try {
      final response = await DisHttpClient.post('user/login', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      }
      else {
        final accessToken = response['data']['access_token'];
        await DisLocalStorage().saveData('access_token', accessToken);
        print("Access Token: $accessToken");
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }
}