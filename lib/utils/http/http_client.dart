import 'dart:convert';
import 'package:dis_app/utils/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;

class DisHttpClient {
  static const String _baseUrl =
      '10.0.0.2/api'; // Change api.dis.com with your IP Address

  // GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$_baseUrl/$endpoint'), headers: headers);
    return _handleResponse(response);
  }

  // POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: headers, body: json.encode(body));
    return _handleResponse(response);
  }

  // PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
        headers: headers, body: json.encode(body));
    return _handleResponse(response);
  }

  // DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final headers = await _getHeaders();
    final response =
        await http.delete(Uri.parse('$_baseUrl/$endpoint'), headers: headers);
    return _handleResponse(response);
  }

  // PATCH request
  static Future<Map<String, dynamic>> patch(
      String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    final response = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
        headers: headers, body: json.encode(body));
    return _handleResponse(response);
  }

  // Multipart Request
  static Future<http.MultipartRequest> multipartRequest(
      String endpoint, String method) async {
    final headers = await _getHeaders();
    var request =
        http.MultipartRequest(method, Uri.parse('$_baseUrl/$endpoint'));
    request.headers.addAll(headers);
    return request;
  }

  // NEW: FindMe request
  static Future<Map<String, dynamic>> findMe(String userId) async {
    final endpoint = 'face/findme/$userId';
    return await get(endpoint);
  }

  // Get Headers
  static Future<Map<String, String>> _getHeaders() async {
    final token = await DisLocalStorage().readData<String>('access_token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.body}');
    }
  }
}
