import 'package:dis_app/models/user_model.dart';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:dis_app/utils/local_storage/local_storage.dart';

class UserController {
  Future<Map<String, dynamic>> get() async {
    try {
      final response = await DisHttpClient.get('user/current');
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        print(response['data']);
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<Map<String, dynamic>> update(UpdateUserRequest request) async {
    try {
      final response = await DisHttpClient.patch('user/update', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await DisHttpClient.post('user/logout', {});
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        await DisLocalStorage().removeData('access_token');
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to logout user: $e');
    }
  }

  Future<Map<String, dynamic>> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await DisHttpClient.patch('user/change_password', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<Map<String, dynamic>> addAccount(AddAccountRequest request) async {
    try {
      final response = await DisHttpClient.post('user/add_account', request.toJson());
      if (response['data'] == null) {
        throw response['errors'];
      } else {
        return response['data'];
      }
    } catch (e) {
      throw Exception('Failed to add account: $e');
    }
  }
}